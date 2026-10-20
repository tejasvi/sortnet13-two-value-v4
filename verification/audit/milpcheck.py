#!/usr/bin/env python3
# Independent re-implementation of the abstract-model search as one MILP per configuration.
# Config = (ordered or unordered binary tree B with N leaves, height <= H) + pass-through counts per segment
# with delta(x) <= H.  For each config: binaries z[s][r][d] (source s -> root r at depth d), dead[s] for
# pass-through sources, Kraft equality per root, acyclicity by ordering variables, route lower bounds
# (big-M), cost <= L for every ordered pair.  Feasible <=> some structure with max |W| <= L exists.
import sys, itertools, functools, time
import highspy

def lg_ceil(n):
    k = 0
    while (1 << k) < n: k += 1
    return k

@functools.lru_cache(maxsize=None)
def ordered_trees(n, h):
    if n == 1: return ('L',)
    if h == 0: return ()
    res = []
    for a in range(1, n):
        for s in ordered_trees(a, h - 1):
            for t in ordered_trees(n - a, h - 1):
                res.append((s, t))
    return tuple(res)

def canon_tree(t):
    if t == 'L': return 'L'
    a, b = canon_tree(t[0]), canon_tree(t[1])
    return '(' + min(a, b) + max(a, b) + ')'

class Tree:
    def __init__(self, t, N):
        self.N = N
        self.par = {}; self.ch = {}; self.depth = {}
        self.leafcnt = 0; self.intcnt = N
        self.root = self._build(t, 0)
        self.par[self.root] = None
        self.TOT = 2 * N - 1
        assert self.leafcnt == N and self.intcnt == self.TOT
    def _build(self, t, d):
        if t == 'L':
            v = self.leafcnt; self.leafcnt += 1; self.depth[v] = d; self.ch[v] = None; return v
        a = self._build(t[0], d + 1); b = self._build(t[1], d + 1)
        v = self.intcnt; self.intcnt += 1
        self.ch[v] = (a, b); self.par[a] = v; self.par[b] = v; self.depth[v] = d
        return v
    def path_up(self, x):  # nodes from x up to root inclusive
        out = []; v = x
        while v is not None: out.append(v); v = self.par[v]
        return out
    def is_anc(self, u, v):  # u ancestor-or-equal of v
        while v is not None:
            if v == u: return True
            v = self.par[v]
        return False
    def lca(self, x, y):
        a = x
        while not self.is_anc(a, y): a = self.par[a]
        return a

def kseg_assignments(T, H):
    """all kseg (dict node->count) with delta(x) <= H for every leaf x"""
    N = T.N
    leaves_below = {}
    def lb(v):
        if T.ch[v] is None: leaves_below[v] = [v]; return
        lb(T.ch[v][0]); lb(T.ch[v][1]); leaves_below[v] = leaves_below[T.ch[v][0]] + leaves_below[T.ch[v][1]]
    lb(T.root)
    # branch count on path of x
    nbr = {x: sum(1 for u in T.path_up(x) if u >= N) for x in range(N)}
    order = []  # top-down
    def pre(v):
        order.append(v)
        if T.ch[v] is not None: pre(T.ch[v][0]); pre(T.ch[v][1])
    pre(T.root)
    used = {x: nbr[x] for x in range(N)}
    ks = {}
    def rec(i):
        if i == len(order):
            yield dict(ks); return
        v = order[i]
        cap = min(H - used[x] for x in leaves_below[v])
        for k in range(0, cap + 1):
            ks[v] = k
            for x in leaves_below[v]: used[x] += k
            yield from rec(i + 1)
            for x in leaves_below[v]: used[x] -= k
        del ks[v]
    if min(H - used[x] for x in range(N)) < 0: return
    yield from rec(0)

def canon_cfg(T, ks, v=None):  # abs5-compatible canonical string
    if v is None: v = T.root
    me = 'k' + str(ks[v])
    if T.ch[v] is None: return me + 'L'
    a = canon_cfg(T, ks, T.ch[v][0]); b = canon_cfg(T, ks, T.ch[v][1])
    if b < a: a, b = b, a
    return me + '(' + a + ',' + b + ')'

def solve_config(T, ks, L, H, want_solution=False, time_limit=600):
    N = T.N; TOT = T.TOT
    internal = list(range(N, TOT))
    pts = []  # (v, i)
    for v in range(TOT):
        for i in range(ks[v]): pts.append((v, i))
    NP = len(pts)
    ptid = {p: j for j, p in enumerate(pts)}
    seglist = {v: [ptid[(v, i)] for i in range(ks[v])] for v in range(TOT)}
    # delta, pre
    delta = {x: sum(ks[u] + (1 if u >= N else 0) for u in T.path_up(x)) for x in range(N)}
    if max(delta.values()) > H: return 'delta>H', None
    def pre(y, c):
        cnt = 0; v = y
        while v != c:
            cnt += ks[v]; p = T.par[v]
            if p != c: cnt += 1
            v = p
        return cnt
    # sources: ('b', c) for internal, ('p', j) for pt;  roots: 'OM' or ('q', j)
    srcs = [('b', c) for c in internal] + [('p', j) for j in range(NP)]
    roots = ['OM'] + [('q', j) for j in range(NP)]
    D = list(range(0, L + 1))
    def on_path(j, x): return T.is_anc(pts[j][0], x)
    def port_cost(j, x):
        v, i = pts[j]
        cost = 1 + (ks[v] - 1 - i)
        w = T.par[v]
        while not T.is_anc(w, x):
            cost += 1 + ks[w]; w = T.par[w]
        return cost, w
    h = highspy.Highs()
    h.setOptionValue('output_flag', False)
    h.setOptionValue('time_limit', float(time_limit))
    h.setOptionValue('threads', 1)
    z = {}
    for s in srcs:
        for r in roots:
            for d in D:
                z[s, r, d] = h.addBinary()
    dead = {s: h.addBinary() for s in srcs if s[0] == 'p'}
    for s in srcs:
        expr = sum(z[s, r, d] for r in roots for d in D)
        if s in dead: expr = expr + dead[s]
        h.addConstr(expr == 1)
    for r in roots:
        h.addConstr(sum((1 << (L - d)) * z[s, r, d] for s in srcs for d in D) == (1 << L))
    # acyclicity
    comps = [('b', c) for c in internal] + [('p', j) for j in range(NP)]
    BT = len(comps) + 2
    t = {k: h.addVariable(lb=0, ub=len(comps) + 1) for k in comps}
    for v in range(TOT):
        chain = ([('b', v)] if v >= N else []) + [('p', j) for j in seglist[v]]
        if T.par[v] is not None: chain.append(('b', T.par[v]))
        for a, b in zip(chain, chain[1:]):
            h.addConstr(t[b] - t[a] >= 1)
    def comp_of(s): return s  # source s's comparator id has the same key
    for s in srcs:
        for j in range(NP):
            used = sum(z[s, ('q', j), d] for d in D)
            h.addConstr(t[('p', j)] - t[comp_of(s)] >= 1 - BT * (1 - used))
    # routes
    pcmax = 0
    for j in range(NP):
        for x in range(N):
            if not on_path(j, x): pcmax = max(pcmax, port_cost(j, x)[0])
    BIG = L + 1
    RMAX = len(srcs) * (L + pcmax + 1) + BIG + 5
    BM = RMAX + L + pcmax + 5
    R = {(x, s): h.addVariable(lb=0, ub=RMAX) for x in range(N) for s in srcs}
    def src_of_node(w): return ('b', w)
    for x in range(N):
        for s in srcs:
            h.addConstr(R[x, s] - sum(d * z[s, 'OM', d] for d in D) >= 0)
            if s in dead: h.addConstr(R[x, s] - BIG * dead[s] >= 0)
            for j in range(NP):
                used = sum(z[s, ('q', j), d] for d in D)
                dep = sum(d * z[s, ('q', j), d] for d in D)
                if on_path(j, x):
                    h.addConstr(R[x, s] - dep - R[x, ('p', j)] - BM * used >= -BM)
                else:
                    pc, w = port_cost(j, x)
                    h.addConstr(R[x, s] - dep - R[x, src_of_node(w)] - BM * used >= pc - BM)
    for x in range(N):
        for y in range(N):
            if x == y: continue
            c = T.lca(x, y)
            h.addConstr(R[x, ('b', c)] <= L - delta[x] - pre(y, c))
    h.run()
    st = h.getModelStatus()
    if st == highspy.HighsModelStatus.kInfeasible: return 'infeasible', None
    if st == highspy.HighsModelStatus.kOptimal:
        sol = None
        if want_solution:
            val = h.getSolution().col_value
            sol = {}
            for s in srcs:
                if s in dead and val[dead[s].index] > 0.5: sol[s] = None; continue
                for r in roots:
                    for d in D:
                        if val[z[s, r, d].index] > 0.5: sol[s] = (r, d)
        return 'feasible', (sol, pts, srcs)
    return 'status:' + str(st), None

def main():
    N = int(sys.argv[1]); L = int(sys.argv[2])
    dedup = (sys.argv[3] if len(sys.argv) > 3 else 'dedup') == 'dedup'
    H = L - lg_ceil(N - 1)
    if H < 1:
        print(f'N={N} L={L} H={H}: no trees'); return
    trees = ordered_trees(N, H)
    print(f'N={N} L={L} H={H} ordered trees={len(trees)} unordered={len(set(canon_tree(t) for t in trees))}', flush=True)
    seen = set(); ncfg = 0; nfeas = 0; feas_cfgs = []; other = []
    t0 = time.time()
    for t in trees:
        T = Tree(t, N)
        for ks in kseg_assignments(T, H):
            cc = canon_cfg(T, ks)
            if dedup:
                if cc in seen: continue
                seen.add(cc)
            ncfg += 1
            res, info = solve_config(T, ks, L, H)
            if res == 'feasible':
                nfeas += 1; feas_cfgs.append(cc)
            elif res != 'infeasible':
                other.append((cc, res))
            print(f'CFG {cc} {res}', flush=True)
    print(f'TOTAL N={N} L={L} configs={ncfg} feasible_configs={nfeas} other={len(other)} time={time.time()-t0:.1f}s')
    for cc, r in other: print('OTHER', cc, r)

if __name__ == '__main__':
    main()
