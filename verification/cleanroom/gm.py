"""GM search: exhaustive search over the tree model ("GM") derived in METHOD.md.

GM instance = (B, unary placement, specs):
  * B: binary M-tree shape with N leaves (unordered);
  * unary nodes on edges of B (including above the root);
  * spec of every merge (and optionally of unary nodes): root in {END} u U,
    dist >= 0, with Kraft sum_{v: root(v)=r} 2^-dist(v) <= 1 for every root r;
  * T(v): END -> dist; d ancestor of v -> dist + T(d);
          d incomparable -> dist + 1 + climb(d, e) + T(e),  e = lca(d, v);
          d descendant of v or d = v -> forbidden (cycle in the network).
  * cost(x,y) = |P_x u P_y| + T(lca(x,y)) <= L for all leaf pairs.
Extra necessary condition (fixed-x Kraft, valid for every network):
  d(x) = |P_x| <= L - ceil(log2(N-1)).
"""
import sys, itertools, functools, time
from sim import trees, nleaves


def clog2(n):
    k = 0
    while (1 << k) < n:
        k += 1
    return k


class MT:
    """M-tree with unary nodes. Comparator nodes get ids; leaves are separate."""

    def __init__(self, B, ucount):
        # ucount: dict B-node-id -> number of unary nodes on the edge above it
        self.kind = []      # 'B' or 'U'
        self.parent = []    # parent comparator id or -1 (top)
        self.leaf_parent = []  # for each leaf: comparator id directly above
        self.children = []  # list of child comparator ids
        self.leaves_under = []
        bid = [0]

        def new(kind):
            self.kind.append(kind)
            self.parent.append(-1)
            self.children.append([])
            return len(self.kind) - 1

        def rec(s):
            # returns (bottom attach list) : builds subtree, returns id of top
            # comparator of this B-node's chain (or ('leaf', idx) for a leaf)
            my = bid[0]
            bid[0] += 1
            if s == 0:
                cur = ('leaf', len(self.leaf_parent))
                self.leaf_parent.append(None)
            else:
                a = rec(s[0])
                b = rec(s[1])
                m = new('B')
                for ch in (a, b):
                    self._attach(ch, m)
                cur = m
            for _ in range(ucount.get(my, 0)):
                u = new('U')
                self._attach(cur, u)
                cur = u
            return cur
        top = rec(B)
        if isinstance(top, tuple):
            raise ValueError("N=1")
        self.top = top
        n = len(self.kind)
        # depth (number of comparators from node up to top, inclusive)
        self.h = [0] * n
        order = []
        stack = [top]
        while stack:
            v = stack.pop()
            order.append(v)
            self.h[v] = 1 + (self.h[self.parent[v]] if self.parent[v] >= 0 else 0)
            stack.extend(self.children[v])
        self.order = sorted(range(n), key=lambda v: self.h[v])  # top-down
        self.anc = []
        for v in range(n):
            a, u = [], self.parent[v]
            while u >= 0:
                a.append(u)
                u = self.parent[u]
            self.anc.append(a)   # proper ancestors, bottom-up
        self.ancset = [set(a) for a in self.anc]
        self.desc = [set() for _ in range(n)]
        for v in range(n):
            for a in self.anc[v]:
                self.desc[a].add(v)
        # leaves: path comparators
        self.nleaf = len(self.leaf_parent)
        self.leafpath = []
        for x in range(self.nleaf):
            p = self.leaf_parent[x]
            self.leafpath.append([p] + self.anc[p])
        # for each comparator: leaves below
        self.below = [[] for _ in range(n)]
        for x in range(self.nleaf):
            for v in self.leafpath[x]:
                self.below[v].append(x)

    def _attach(self, ch, par):
        if isinstance(ch, tuple):
            self.leaf_parent[ch[1]] = par
        else:
            self.parent[ch] = par
            self.children[par].append(ch)

    def lca(self, a, b):
        sa = set([a] + self.anc[a])
        for u in [b] + self.anc[b]:
            if u in sa:
                return u
        raise RuntimeError

    def climb(self, d, e):
        # comparators strictly between d and e on the path d -> e
        return self.h[d] - self.h[e] - 1

    def D(self):
        """D(c) for merges: max over leaf pairs with lca c of |P_x u P_y|."""
        out = {}
        for c in range(len(self.kind)):
            if self.kind[c] != 'B':
                continue
            ch = self.children[c]
            assert len(ch) + sum(1 for x in range(self.nleaf) if self.leaf_parent[x] == c) == 2
            # children sides: each side = comparator child or leaf
            sides = []
            for k in ch:
                sides.append(max(self.h[self.leaf_parent[x]] for x in self.below[k]) - self.h[c])
            for x in range(self.nleaf):
                if self.leaf_parent[x] == c:
                    sides.append(0)
            assert len(sides) == 2
            out[c] = self.h[c] + sides[0] + sides[1]
        return out


def placements(B, Hmax):
    """All unary-count assignments (dict: preorder B-node id -> count) with
    every leaf path length (merges + unary nodes) <= Hmax."""
    @functools.lru_cache(None)
    def hb(s):  # merges on the longest downward path, including s itself
        return 0 if s == 0 else 1 + max(hb(s[0]), hb(s[1]))

    @functools.lru_cache(None)
    def size(s):
        return 1 if s == 0 else 1 + size(s[0]) + size(s[1])

    def go(s, my, used):
        out = []
        kmax = Hmax - used - hb(s)
        for k in range(kmax + 1):
            if s == 0:
                out.append({my: k} if k else {})
                continue
            left = go(s[0], my + 1, used + k + 1)
            right = go(s[1], my + 1 + size(s[0]), used + k + 1)
            for a in left:
                for b in right:
                    d = dict(a)
                    d.update(b)
                    if k:
                        d[my] = k
                    out.append(d)
        return out
    return go(B, 0, 0)


def spec_search(mt, L, want_witness=False):
    """Decide whether specs exist with T(c) <= L - D(c) for every merge."""
    Dc = mt.D()
    beta = {c: L - d for c, d in Dc.items()}
    if any(b < 0 for b in beta.values()):
        return None
    n = len(mt.kind)
    U = [v for v in range(n) if mt.kind[v] == 'U']
    # referenceability
    has_unary_below = [any(mt.kind[w] == 'U' for w in mt.desc[v]) for v in range(n)]
    has_comp_below = [len(mt.desc[v]) > 0 for v in range(n)]
    Tmax = max(beta.values())
    order = mt.order
    CAP = 1 << (L + 1)
    tau = [None] * n
    root = [None] * n
    dist = [None] * n
    mass = {'END': 0}
    for d in U:
        mass[d] = 0
    sol = []

    def options(v):
        """Yield (r, offset) pairs available to v given ancestors' tau."""
        yield ('END', 0)
        for d in U:
            if d == v or d in mt.desc[v]:
                continue
            if d in mt.ancset[v]:
                if tau[d] is None:
                    continue
                yield (d, tau[d])
            else:
                e = mt.lca(d, v)
                assert mt.kind[e] == 'B' and e in mt.ancset[v] and e in mt.ancset[d]
                yield (d, 1 + mt.climb(d, e) + tau[e])

    def rec(i):
        if i == len(order):
            if want_witness:
                sol.append((list(root), list(dist), list(tau)))
            return True
        v = order[i]
        if mt.kind[v] == 'B':
            hi = beta[v]
            referenceable = has_unary_below[v]
        else:
            hi = Tmax
            referenceable = has_comp_below[v]
            # option: unused
            tau[v] = None
            if rec(i + 1):
                return True
            if not referenceable:
                return False
        for (r, off) in list(options(v)):
            if referenceable:
                tvals = range(hi, off - 1, -1)
            else:
                tvals = [hi] if hi >= off else []
            for t in tvals:
                dd = t - off
                if dd < 0:
                    continue
                m = CAP >> dd          # 2^-dd in units of 1/CAP (dd <= L)
                if mass[r] + m > CAP:  # Kraft per root
                    continue
                mass[r] += m
                tau[v], root[v], dist[v] = t, r, dd
                ok = rec(i + 1)
                mass[r] -= m
                tau[v], root[v], dist[v] = None, None, None
                if ok:
                    return True
        return False
    ok = rec(0)
    if ok:
        return sol[0] if want_witness else True
    return False


def gm_feasible(N, L, verbose=False, stats=None, pure=False):
    Hmax = L if pure else L - clog2(N - 1)
    found = None
    cnt = [0, 0]
    for B in trees(N):
        from sim import height
        if height(B) > Hmax:
            continue
        for uc in placements(B, Hmax):
            cnt[0] += 1
            mt = MT(B, uc)
            # sanity: path lengths
            assert all(len(p) <= Hmax for p in mt.leafpath)
            r = spec_search(mt, L, want_witness=True)
            if r:
                cnt[1] += 1
                if found is None:
                    found = (B, uc, r)
                if not (stats is not None and stats.get('all')):
                    if stats is not None:
                        stats['count'] = cnt
                    return found
    if stats is not None:
        stats['count'] = cnt
    return found


if __name__ == "__main__":
    args = [int(a) for a in sys.argv[1:3]]
    N, L = args
    pure = '-pure' in sys.argv
    t0 = time.time()
    st = {}
    r = gm_feasible(N, L, stats=st, pure=pure)
    print(f"GM{'(pure)' if pure else ''} N={N} L={L}: {'FEASIBLE' if r else 'INFEASIBLE'}  (instances (B,U) examined={st['count'][0]}) time={time.time()-t0:.2f}s")
    if r:
        B, uc, (root, dist, tau) = r
        print("  B =", B, " unary counts =", uc)


def placements_pairbound(B, L):
    """All unary-count assignments such that every merge c has
    D(c) = h(c) + a(c) + b(c) <= L  (|P_x u P_y| <= cost <= L: trivially
    necessary).  No Kraft-type condition is used."""
    @functools.lru_cache(None)
    def size(s):
        return 1 if s == 0 else 1 + size(s[0]) + size(s[1])

    def go(s, my, used):
        # returns list of (dict, maxlen) where maxlen = comparators on the
        # longest path from the top of this node's unary chain down to a leaf
        out = []
        k = 0
        while True:
            if s == 0:
                if used + k > L:
                    break
                out.append(({my: k} if k else {}, k))
            else:
                hc = used + k + 1
                if hc > L:
                    break
                left = go(s[0], my + 1, hc)
                right = go(s[1], my + 1 + size(s[0]), hc)
                any_ok = False
                for a, la in left:
                    for b, lb in right:
                        if hc + la + lb <= L:
                            d = dict(a)
                            d.update(b)
                            if k:
                                d[my] = k
                            out.append((d, k + 1 + max(la, lb)))
                            any_ok = True
                if not any_ok and k > 0:
                    break
                if not left or not right:
                    break
            k += 1
        return out
    return [d for d, _ in go(B, 0, 0)]


def gm_feasible_pure2(N, L, stats=None):
    found = None
    cnt = [0, 0]
    for B in trees(N):
        for uc in placements_pairbound(B, L):
            cnt[0] += 1
            mt = MT(B, uc)
            r = spec_search(mt, L, want_witness=True)
            if r:
                cnt[1] += 1
                if found is None:
                    found = (B, uc, r)
                    break
        if found:
            break
    if stats is not None:
        stats['count'] = cnt
    return found
