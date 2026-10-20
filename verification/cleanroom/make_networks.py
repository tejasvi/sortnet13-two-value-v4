"""Write explicit optimal networks (simple model) for N=3..13 to networks.txt,
re-verified by full simulation of all N(N-1) runs."""
from sim import simple_P, build_simple_network, simulate, trees, simple_feasible
with open('networks.txt', 'w') as f:
    f.write("# comparator (lo,hi): after it, channel hi holds the max, channel lo the min\n")
    for N in range(3, 14):
        L, t = simple_P(N)
        net, oM, om = build_simple_network(t, L)
        ok, oM2, om2, cost = simulate(net, N)
        assert ok and (oM2, om2) == (oM, om) and max(cost.values()) == L
        f.write(f"N={N} P2={L} comparators={len(net)} oM={oM} om={om} runs={len(cost)} max|W|={max(cost.values())} M-tree={t}\n")
        f.write("  " + " ".join(f"({a},{b})" for a, b in net) + "\n")
        print(f"N={N}: simulated {len(cost)} runs, top-2 correct={ok}, p2={max(cost.values())}, comparators={len(net)}")


def untangle(net, N):
    """Same DAG, standard form (every comparator has lo < hi)."""
    perm = list(range(N))  # logical channel -> physical channel
    out = []
    for lo, hi in net:
        a, b = perm[lo], perm[hi]
        if a < b:
            out.append((a, b))
        else:
            out.append((b, a))      # max lands on physical a = perm[lo]
            perm[lo], perm[hi] = b, a
    return out, perm


with open('networks.txt', 'a') as f:
    f.write("\n# Standard-form versions (every comparator (i,j) has i<j: min->i, max->j), same DAGs\n")
    for N in range(3, 14):
        L, t = simple_P(N)
        net, oM, om = build_simple_network(t, L)
        std, perm = untangle(net, N)
        assert all(a < b for a, b in std)
        ok, oM2, om2, cost = simulate(std, N)
        assert ok and max(cost.values()) == L and oM2 == perm[oM] and om2 == perm[om]
        f.write(f"N={N} P2={L} standard-form, oM={oM2} om={om2}, simulated max|W|={max(cost.values())}\n")
        f.write("  " + " ".join(f"({a},{b})" for a, b in std) + "\n")
        print(f"N={N}: standard form verified, oM={oM2}, om={om2}, p2={max(cost.values())}")
