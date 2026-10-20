"""Randomized tests: map random top-2-correct networks to the GM model and check
  (1) cost(x,y) == |P_x u P_y| + T(lca(x,y))   (T computed by the GM recursion
      from the extracted F-forest), for all x != y;
  (2) Kraft per F-root over used nodes;
  (3) fixed-x bound  d(x) <= p2 - ceil(log2(N-1));
  (4) gm.spec_search on the extracted (B, unary placement) at L = p2 is feasible;
  (5) every prefix state passes the bf2 Kraft test (and P1) at L = p2.
"""
import random, sys, math
from sim import simulate, trees, nleaves, build_simple_network
import gm


def leads_of(net, N):
    cur = list(range(N))
    nxt = N
    comp_in, comp_hi, comp_lo = [], [], []
    dest = {}
    for k, (lo, hi) in enumerate(net):
        a, b = cur[lo], cur[hi]
        dest[a] = k
        dest[b] = k
        comp_in.append((a, b))
        comp_hi.append(nxt)
        comp_lo.append(nxt + 1)
        cur[hi], cur[lo] = nxt, nxt + 1
        nxt += 2
    return comp_in, comp_hi, comp_lo, dest, cur


def analyse(net, N, check_spec=True, check_prefix=True):
    ok, oM, om, cost = simulate(net, N)
    assert ok
    p2 = max(cost.values())
    comp_in, comp_hi, comp_lo, dest, final = leads_of(net, N)
    # M paths and region R
    P = []
    R = set()
    for x in range(N):
        lead, path = x, []
        R.add(lead)
        while lead in dest:
            k = dest[lead]
            path.append(k)
            lead = comp_hi[k]
            R.add(lead)
        P.append(path)
    tree = {k for k in range(len(net)) if comp_hi[k] in R}
    kind = {}
    for k in tree:
        nin = sum(1 for l in comp_in[k] if l in R)
        assert nin in (1, 2)
        kind[k] = 'B' if nin == 2 else 'U'
    # non-tree comparators: neither input in R
    for k in range(len(net)):
        if k not in tree:
            assert all(l not in R for l in comp_in[k])
    parent = {k: dest.get(comp_hi[k]) for k in tree}
    h = {}

    def H(k):
        if k not in h:
            h[k] = 1 if parent[k] is None else 1 + H(parent[k])
        return h[k]
    anc = {}
    for k in tree:
        a, u = [], parent[k]
        while u is not None:
            a.append(u)
            u = parent[u]
        anc[k] = a
    # F-forest walk
    root, dist = {}, {}
    for v in tree:
        lead, d = comp_lo[v], 0
        while True:
            if lead not in dest:
                root[v] = 'END'
                break
            g = dest[lead]
            if g in tree:
                assert kind[g] == 'U' and lead not in R
                root[v] = g
                break
            d += 1
            lead = comp_hi[g]
        dist[v] = d

    def lca(a, b):
        sa = set([a] + anc[a])
        for u in [b] + anc[b]:
            if u in sa:
                return u
        raise RuntimeError
    memo = {}

    def T(v):
        if v in memo:
            return memo[v]
        r = root[v]
        if r == 'END':
            t = dist[v]
        elif r in anc[v]:
            t = dist[v] + T(r)
        else:
            assert r != v and v not in anc[r], "cycle"
            e = lca(r, v)
            assert kind[e] == 'B'
            t = dist[v] + 1 + (H(r) - H(e) - 1) + T(e)
        memo[v] = t
        return t
    # (1) cost formula + used nodes (via simulation of knockouts)
    used = set(k for k in tree if kind[k] == 'B')
    for x in range(N):
        for y in range(N):
            if x == y:
                continue
            c = lca(P[x][0], P[y][0])
            pred = len(set(P[x]) | set(P[y])) + T(c)
            assert pred == cost[(x, y)], (x, y, pred, cost[(x, y)])
            # knockouts
            pM, pm = x, y
            for k, (lo, hi) in enumerate(net):
                inM, inm = pM in (lo, hi), pm in (lo, hi)
                if inM and inm:
                    pM, pm = hi, lo
                    used.add(k)
                elif inM:
                    pM = hi
                elif inm:
                    pm = hi
    for k in used:
        assert k in tree
    # (2) Kraft per root over used nodes
    from fractions import Fraction
    mass = {}
    for v in used:
        mass[root[v]] = mass.get(root[v], 0) + Fraction(1, 2 ** dist[v])
    assert all(m <= 1 for m in mass.values()), mass
    # (3) fixed-x bound
    Hmax = p2 - gm.clog2(N - 1)
    assert all(len(P[x]) <= Hmax for x in range(N)), ([len(p) for p in P], p2)
    nunary = sum(1 for k in tree if kind[k] == 'U')
    graft = sum(1 for v in used if root[v] != 'END' and root[v] not in anc[v])
    knock = sum(1 for v in used if root[v] != 'END' and root[v] in anc[v])
    # (4) spec_search on extracted shape
    if check_spec:
        top = [k for k in tree if parent[k] is None]
        assert len(top) == 1
        B, uc = to_B(top[0], tree, kind, comp_in, R, comp_hi, dest)
        mt = gm.MT(B, uc)
        assert sorted(len(p) for p in P) == sorted(len(p) for p in mt.leafpath)
        # D(c) computed directly from the network's M paths vs MT.D()
        Dnet = {}
        for x in range(N):
            for y in range(N):
                if x != y:
                    c = lca(P[x][0], P[y][0])
                    Dnet[c] = max(Dnet.get(c, 0), len(set(P[x]) | set(P[y])))
        assert sorted(Dnet.values()) == sorted(mt.D().values()), (Dnet, mt.D())
        r = gm.spec_search(mt, p2)
        assert r, "spec_search failed on extracted instance"
    # (5) prefix Kraft
    if check_prefix:
        runs = {(x, y): (x, y, 0) for x in range(N) for y in range(N) if x != y}
        for k in range(len(net) + 1):
            st = {}
            for (pM, pm, c) in runs.values():
                st[(pM, pm)] = max(st.get((pM, pm), -1), c)
            assert kraft_ok(st, p2, N), ("prefix kraft fail", k)
            frozen = sum(1 for c in st.values() if c == p2)
            assert frozen <= 1 and (frozen == 0 or len(st) == 1), "P1 fail"
            if k == len(net):
                break
            lo, hi = net[k]
            for key, (pM, pm, c) in list(runs.items()):
                inM, inm = pM in (lo, hi), pm in (lo, hi)
                if inM or inm:
                    c += 1
                    if inM and inm:
                        pM, pm = hi, lo
                    elif inM:
                        pM = hi
                    else:
                        pm = hi
                runs[key] = (pM, pm, c)
    return dict(p2=p2, unary=nunary, graft=graft, knock=knock)


def kraft_ok(st, L, N):
    lim, tot = 1 << L, 0
    for p in range(N):
        sp = sum(1 << c for (a, b), c in st.items() if a == p)
        if sp == 0:
            continue
        if sp > lim:
            return False
        A = 0
        while (sp << (A + 1)) <= lim:
            A += 1
        tot += 1 << (L - A)
    return tot <= lim


def to_B(top, tree, kind, comp_in, R, comp_hi, dest):
    """Convert extracted M-tree to (B nested tuple, unary counts by preorder id)."""
    src = {}
    for k in tree:
        src[comp_hi[k]] = k

    def child_of_lead(l):
        return ('leaf', l) if l not in src else src[l]

    def node(k):
        cnt = 0
        while not isinstance(k, tuple) and kind[k] == 'U':
            cnt += 1
            a = [l for l in comp_in[k] if l in R]
            assert len(a) == 1
            k = child_of_lead(a[0])
        if isinstance(k, tuple):
            return (cnt, None)
        ch = [child_of_lead(l) for l in comp_in[k]]
        return (cnt, (node(ch[0]), node(ch[1])))
    struct = node(top)
    uc = {}
    idx = [0]

    def flat(s):
        cnt, ch = s
        my = idx[0]
        idx[0] += 1
        if cnt:
            uc[my] = cnt
        if ch is None:
            return 0
        a = flat(ch[0])
        b = flat(ch[1])
        return (a, b)
    B = flat(struct)
    return B, uc


def bubble(N):
    return [(j, j + 1) for i in range(N - 1, 0, -1) for j in range(i)]


def oddeven(N):
    return [(j, j + 1) for r in range(N) for j in range(r % 2, N - 1, 2)]


def rand_comp(N, rng):
    a, b = rng.sample(range(N), 2)
    return (a, b)


def rand_simple(N, rng):
    # random M-tree shape + random m-tree pairing (always top-2 correct)
    t = rng.choice(trees(N))
    net, nxt, los = [], [0], []

    def rec(s):
        if s == 0:
            c = nxt[0]
            nxt[0] += 1
            return c
        a, b = rec(s[0]), rec(s[1])
        if rng.random() < 0.5:
            a, b = b, a
        net.append((b, a))
        los.append(b)
        return a
    perm = list(range(N))
    rng.shuffle(perm)
    rec(t)
    pool = los[:]
    while len(pool) > 1:
        i, j = rng.sample(range(len(pool)), 2)
        a, b = pool[i], pool[j]
        net.append((b, a))
        pool = [p for k, p in enumerate(pool) if k not in (i, j)] + [a]
    return [(perm[a], perm[b]) for a, b in net]


def gen(N, rng):
    kind = rng.randrange(4)
    pre = [rand_comp(N, rng) for _ in range(rng.randrange(0, 2 * N))]
    if kind == 0:
        body = bubble(N)
    elif kind == 1:
        body = oddeven(N)
    else:
        body = rand_simple(N, rng)
    perm = list(range(N))
    rng.shuffle(perm)
    body = [(perm[a], perm[b]) for a, b in body]
    net = pre + body
    # random insertions that keep top-2 correctness
    for _ in range(rng.randrange(0, N)):
        pos = rng.randrange(len(net) + 1)
        cand = net[:pos] + [rand_comp(N, rng)] + net[pos:]
        if simulate(cand, N)[0]:
            net = cand
    return net


if __name__ == "__main__":
    seed = int(sys.argv[1]) if len(sys.argv) > 1 else 1
    count = int(sys.argv[2]) if len(sys.argv) > 2 else 200
    Nmax = int(sys.argv[3]) if len(sys.argv) > 3 else 7
    rng = random.Random(seed)
    agg = dict(n=0, unary=0, graft=0, knock=0)
    for it in range(count):
        N = rng.randrange(3, Nmax + 1)
        net = gen(N, rng)
        if not simulate(net, N)[0]:
            continue
        r = analyse(net, N, check_spec=(N <= 7))
        agg['n'] += 1
        agg['unary'] += r['unary'] > 0
        agg['graft'] += r['graft'] > 0
        agg['knock'] += r['knock'] > 0
    print("seed", seed, "networks tested:", agg['n'], "| with unary nodes:", agg['unary'],
          "| with grafting:", agg['graft'], "| with unary knockouts:", agg['knock'], "| ALL CHECKS PASSED")
