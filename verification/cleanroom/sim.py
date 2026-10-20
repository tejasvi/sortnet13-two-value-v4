"""Clean-room tools for top-2 comparator networks.

Network = list of comparators (lo, hi): channels; after the comparator,
channel `hi` carries max of the two inputs and channel `lo` the min.
(Generalized networks: lo/hi may be in either order of index.)
"""
import itertools, functools, sys
from fractions import Fraction


def simulate(net, N):
    """Return (ok, oM, om, cost) where cost[(x,y)] = |W(x,y)|.
    ok = top-2 correct (M always ends on oM, m always on om)."""
    cost = {}
    endsM, endsm = set(), set()
    for x in range(N):
        for y in range(N):
            if x == y:
                continue
            pM, pm, c = x, y, 0
            for (lo, hi) in net:
                inM = pM == lo or pM == hi
                inm = pm == lo or pm == hi
                if inM or inm:
                    c += 1
                    if inM and inm:
                        pM, pm = hi, lo
                    elif inM:
                        pM = hi
                    else:
                        pm = hi
            cost[(x, y)] = c
            endsM.add(pM)
            endsm.add(pm)
    ok = len(endsM) == 1 and len(endsm) == 1
    oM = next(iter(endsM)) if len(endsM) == 1 else None
    om = next(iter(endsm)) if len(endsm) == 1 else None
    return ok, oM, om, cost


def p2(net, N):
    ok, oM, om, cost = simulate(net, N)
    return ok, max(cost.values())


# ---------- binary trees (unordered), leaf = 0, internal = (a, b) ----------
def nleaves(t):
    return 1 if t == 0 else nleaves(t[0]) + nleaves(t[1])


def key(t):
    return (nleaves(t), repr(t))


@functools.lru_cache(None)
def trees(n):
    if n == 1:
        return (0,)
    out = []
    for k in range(1, n // 2 + 1):
        for a in trees(k):
            for b in trees(n - k):
                if k == n - k and key(a) > key(b):
                    continue
                out.append((a, b))
    return tuple(out)


def height(t):
    return 0 if t == 0 else 1 + max(height(t[0]), height(t[1]))


def merge_D(t):
    """List of D(c) for every merge c (simple model, no unary nodes):
    D(c) = h(c) + height(left) + height(right), h(root) = 1."""
    out = []

    def rec(s, h):
        if s == 0:
            return
        out.append(h + height(s[0]) + height(s[1]))
        rec(s[0], h + 1)
        rec(s[1], h + 1)
    rec(t, 1)
    return out


def simple_feasible(t, L):
    Ds = merge_D(t)
    if any(L - d < 0 for d in Ds):
        return False
    return sum(Fraction(1, 2 ** (L - d)) for d in Ds) <= 1


def simple_P(N, Lmax=40):
    for L in range(0, Lmax):
        for t in trees(N):
            if simple_feasible(t, L):
                return L, t
    return None


# ---------- explicit network for the simple model ----------
def build_simple_network(t, L):
    """Build comparator list on N channels from tree t whose simple-model
    Kraft condition holds at level L.  M-tree first, then m-tree."""
    N = nleaves(t)
    net = []
    nxt = [0]
    merges = []  # (lo_channel, beta)

    def rec(s, h):
        # returns channel holding the subtree max
        if s == 0:
            ch = nxt[0]
            nxt[0] += 1
            return ch
        a = rec(s[0], h + 1)
        b = rec(s[1], h + 1)
        net.append((b, a))  # hi -> a, lo -> b
        merges.append((b, L - (h + height(s[0]) + height(s[1]))))
        return a
    oM = rec(t, 1)
    # m-tree by level pairing (depth of leaf <= beta guaranteed if Kraft<=1)
    maxb = max(b for _, b in merges) if merges else 0
    levels = {}
    for ch, b in merges:
        assert b >= 0
        levels.setdefault(b, []).append(ch)
    carry = []
    for lev in range(maxb, 0, -1):
        items = levels.get(lev, []) + carry
        carry = []
        for k in range(0, len(items) - 1, 2):
            net.append((items[k + 1], items[k]))  # hi -> items[k]
            carry.append(items[k])
        if len(items) % 2 == 1:
            carry.append(items[-1])
    final = levels.get(0, []) + carry
    assert len(final) == 1, final
    return net, oM, final[0]


if __name__ == "__main__":
    for N in range(3, 14):
        L, t = simple_P(N)
        net, oM, om = build_simple_network(t, L)
        ok, oM2, om2, cost = simulate(net, N)
        assert ok and oM2 == oM and om2 == om
        # also check no tree at L-1
        assert not any(simple_feasible(s, L - 1) for s in trees(N))
        print(N, "simple-model P =", L, "tree", t, "| network:", len(net),
              "comparators, simulated p2 =", max(cost.values()), "ok", ok)
