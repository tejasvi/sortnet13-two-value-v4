# Clean-room determination of P(2,N) for N <= 13

Everything here was written from scratch in this directory
(no code or notes from the main search programs, `src/` of this repository, were read).

## 0. Results

| N | P(2,N) | lower bound: infeasible at L = P-1 | upper bound: network with p2 = P |
|---|---|---|---|
| 3 | 3 | bf (plain), bf2 (plain/-k), GM, GM-pure | simple model, simulated |
| 4 | 4 | same | same |
| 5 | 6 | same | same |
| 6 | 6 | same | same |
| 7 | 7 | same | same |
| 8 | 7 | same | same |
| 9 | **8** | bf2 plain (no Kraft lemma!) 548 s; bf2 -k 0.08 s; GM 0.06 s; GM-pure 0.8 s | simple model (15 comparators), simulated; also bf2 witness |
| 10 | **8** | monotonicity from N=9; also directly: bf2 -k (root), GM, GM-pure 0.3 s | simple model (17), simulated; bf2 witness |
| 11 | **8** | monotonicity from N=9; also directly: bf2 -k (root), GM, GM-pure 0.1 s | simple model (19), simulated; bf2 witness |
| 12 | **9** | bf2 -k 55 s (287,409 states); GM 0.02 s; GM-pure 20 s (94,511 shapes) | simple model (21), simulated; bf2 witness |
| 13 | **9** | bf2 -k 26 s (99,625 states); GM 0.01 s; GM-pure 17 s (64,906 shapes); also monotonicity from N=12 | simple model (23), simulated |

So **P(2,9) = P(2,10) = P(2,11) = 8 and P(2,12) = P(2,13) = 9**; in particular
**P(2,13) >= 9** (no top-2-correct network on 13 channels has all |W(x,y)| <= 8).

The lower bounds were obtained by three methods. Each rests on a different
non-trivial lemma:

* **Method A** (`bf2.cpp`): exhaustive search over comparator networks with
  states compressed and symmetry-reduced (Section 2). It prunes with the
  **Kraft lemma** (Lemma A5). Without that lemma (prunes P0 and P1 only, both
  immediate from the definitions) it still finishes N <= 9, which gives
  P(2,9) >= 8 with no lemma at all beyond the definitions.
* **Method C** (`gm_pure2.py`): exhaustive search over the **tree model GM**
  (Section 3). It relies on the **structure theorem** (Theorem B) and on no
  counting over runs.
* **Method B** (`gm.py`): GM plus the corollary d(x) <= L - ceil(log2(N-1)) of
  Lemma A5. This is the fast variant.

All three agree with each other and with the plain brute force (`bf.cpp`,
P0/P1 only) at every (N, L) with N <= 8 and 2 <= L <= 8. At L = P they all
report feasible, and at L = P-1 (and every lower L) they all report infeasible.

Timings come from a shared multi-core server. Every run was single-threaded
under `nice -n 10`, so the wall-clock times above are approximate. The rerun of the table
(`rerun_table.sh`, log `out/table_cleanroom.txt`) gives the same verdicts and the same counts of
states and shapes, with different wall-clock times.

## 1. Model and basic facts

A network is a DAG of comparators. Each comparator has two input leads and two
output leads, `hi` (max) and `lo` (min). There are N input leads and N output
leads. Writing the DAG as a sequence of comparators on N channels loses
nothing: take a topological order and keep N "current" leads. A comparator
written `(lo, hi)` sends the max to channel `hi` and the min to channel `lo`.
Either index order is allowed (generalized networks). Section 2.2 shows the
orientation never matters for the search.

Run (x,y): M is on input x, m is on input y, and every other value is smaller.
The relative order of the small values never affects M or m. The cost is
|W(x,y)|, the number of comparators that have M or m on an input in that run.
Each comparator is passed at most once by each value, so the cost is a sum of
+1 over the comparators touched.

**Fact 1.** M leaves every comparator it enters on `hi`, so its path depends
only on x. m leaves a comparator on `lo` exactly when M is at the same
comparator, and on `hi` otherwise.

**Monotonicity lemma.** P(2,N) <= P(2,N+1).
*Proof.* Take a top-2-correct T on N+1 channels and put a value -inf on input
z. That value leaves every comparator it enters on `lo`, and its path is fixed.
Delete each comparator on that path. The comparator's other input lead is
joined to its `hi` output lead, and the -inf lead continues from its `lo`
output lead. The result is a network on N channels. In every run (x,y) with
x,y != z, M and m follow the same leads as before, minus the deleted
comparators: at a deleted comparator they would have left on `hi` anyway. So
o_M and o_m are unchanged, and each |W| is unchanged or smaller. QED

Consequently P(2,9) >= 8 gives P(2,10), P(2,11) >= 8, and P(2,12) >= 9
gives P(2,13) >= 9. N = 10, 11 and 13 were nevertheless also checked directly.

## 2. Method A: exhaustive network search (`bf.cpp`, `bf2.cpp`)

### 2.1 State compression (exact)
After a prefix of comparators, each run (x,y) is described by (pM, pm, c): the
channels holding M and m, and the cost so far. The rest of the run depends only
on (pM, pm) and the remaining comparators: by Fact 1 the movement of M and m
depends only on where they are, and cost increments add up. Two runs at the
same (pM, pm) therefore behave identically from then on. So the state

    f(p,q) = max{ c : some run is at (pM,pm) = (p,q) with cost c }

(undefined where no run is at (p,q)) determines everything that matters. The
final p2 is the maximum over the final f, and the network is top-2 correct iff
the final f has exactly one entry (all runs at one pair (o_M, o_m)). The search
is reachability in the graph of states f, starting from f(x,y) = 0 for all
x != y. A goal is a state with exactly one entry. Comparators that touch no
run leave f unchanged and are skipped.

### 2.2 Symmetry (exact)
Relabeling channels by a permutation pi maps networks to networks and maps f to
f∘pi^{-1}. The goal condition is invariant under this, so states in the same
orbit are equivalent.

*Orientation.* Apply `(lo=i, hi=j)` and `(lo=j, hi=i)` to the same state. The
two results differ by the transposition (i j): touched runs get +1 in both, and
every position that moves lands on j in one and on i in the other. So only
comparators with lo < hi are tried. The `-all` flag tries both orientations
and gives the same verdicts (checked N <= 6, and N = 12, 13 at L = 8).

*Dedup.* The dedup key is f re-encoded under a channel order computed by colour
refinement. Remaining ties are enumerated exhaustively when the product of
their factorials is at most 5040; otherwise they are broken by channel index.
Equal keys imply isomorphic states, so dedup never merges inequivalent states.
It may fail to merge some isomorphic states, which costs time but not
correctness. With `-lim 1` (ties always broken by index) the verdicts are the
same.

### 2.3 Prunes
**(P0)** No entry may exceed L. Costs never decrease.

**(P1) Frozen entry.** Suppose an entry (p,q) has cost L. No later comparator
may touch channel p or q, since that would push the run past L. Any other entry
(p',q') would have to end at (p,q), which needs a comparator on p (if p' != p)
or on q (if q' != q). That comparator touches the frozen run. So a live state
has at most one entry of cost L, and if it has one, that is its only entry.
P1 follows directly from P0.

**(P2) Kraft lemma (Lemma A5).** For a state f and level L, let
S_p = sum_{q : f(p,q) defined} 2^{-(L - f(p,q))} and
A_p = max{ a >= 0 : 2^a S_p <= 1 }.
If f is reachable from the start by a prefix that can be completed to a
top-2-correct network with p2 <= L, then S_p <= 1 for every occupied p, and
sum_p 2^{-A_p} <= 1.

*Proof.* Fix such a completion (a suffix network). Let P be the set of occupied
M-channels.

(i) From the current lead of channel p, M's future path Pi_p is determined. A
lead entering comparator g is followed by hi(g). The union of the Pi_p (p in P)
is a set of leads in which every lead has at most one successor. All paths end
at o_M, so it is an in-tree. Its leaves are exactly the current leads of the
channels in P: a current lead has no predecessor inside the suffix, while every
other lead on the tree is the hi output of a comparator entered from the tree.
Call a comparator *binary* for this tree if both its input leads lie on the
tree, and let a_p be the number of binary comparators on Pi_p. Induction from
the leaves (weight 1 at each leaf; a binary comparator averages two weights; a
unary one passes its weight on) gives sum_{p in P} 2^{-a_p} = 1. Every
comparator on Pi_p is touched by every run with M at p.

(ii) Fix p. In every run with M on channel p, M follows Pi_p. A lead l carrying
m that enters comparator g is followed by lo(g) if g is on Pi_p (M is then on
g's other input lead) and by hi(g) otherwise (g's other input then carries a
small value). So for these runs m's motion is a deterministic successor map on
leads. The m-paths from the channels Q_p = {q : f(p,q) defined} form an in-tree
ending at o_m whose leaves are the current leads of Q_p. Let g be a comparator
both of whose input leads lie on these m-paths. Then g is not on Pi_p: if it
were, one of its input leads would be on Pi_p, and that lead carries M in every
such run, so it cannot carry m. Hence such g are touched by m and not by M, and
they are distinct from the comparators in (i). Let k_p(q) be the number of such
g on the m-path from q. Then sum_{q in Q_p} 2^{-k_p(q)} = 1.

(iii) The run of maximal cost f(p,q) at (p,q) finishes with cost at least
f(p,q) + a_p + k_p(q), so f(p,q) + a_p + k_p(q) <= L. Hence
1 = sum_q 2^{-k_p(q)} >= sum_q 2^{-(L - f(p,q) - a_p)} = 2^{a_p} S_p.
This gives S_p <= 1 and a_p <= A_p, so 1 = sum_p 2^{-a_p} >= sum_p 2^{-A_p}.
QED

*Corollary (fixed-x bound).* In (iii), a_p can be replaced by the full length
|Pi_p|, since every comparator on Pi_p is touched. At the start state this
gives d(x) := |P_x| <= L - ceil(log2(N-1)) for every input x of every network
with p2 <= L.

Implementation (`kraft_ok` in bf2.cpp): everything is scaled by 2^L and uses
exact 64-bit integers. sp = sum 2^{f}, the test S_p <= 1 is sp <= 2^L, A_p is
computed by doubling, and the final test is sum 2^{L-A_p} <= 2^L.

### 2.4 Validation of Method A
* `bf.cpp` (N <= 8, P0 + P1 only, both orientations optional) and `bf2.cpp`
  (N <= 16) agree on every verdict for N = 3..7, L = 2..8, in all variants:
  plain, `-k`, `-k -lim 1`, `-all`.
* **Exhaustive soundness test of P1 and P2 (`live.cpp`).** For N = 3..8 the
  full reachable state graph under P0 alone was built for L = 2..9 (N <= 6) and
  L = 6..8 (N = 7, 8); the largest is N=8, L=8 with 11,465,076 states. Each
  state was marked *live* if a goal is reachable from it. In every case **no
  live state fails P1 or the Kraft test**, while the Kraft test removes between
  96% and 99.9% of the dead states. For example, at N=8, L=7: 3,017,935 states, 490 live,
  0 violations.
* **N = 9 without the Kraft lemma:** `bf2 9 7` (P0 + P1 only) explores all
  4,619,670 reachable states in 548 s and finds no goal. P(2,9) >= 8 therefore
  needs nothing beyond Sections 2.1-2.3 (P0, P1).
* Random top-2-correct networks (Section 5): every prefix state passes the
  Kraft test and P1 at L = p2(network).

## 3. Methods B and C: the tree model GM (`gm.py`, `gm_pure2.py`)

### 3.1 The M-tree
Let R be the set of leads that M occupies in at least one run (over all x).
Call a comparator g a *tree comparator* if hi(g) is in R.

**Lemma B1.**
(a) A comparator with an input lead in R is a tree comparator: M arrives on
that input in some run and leaves on hi. Hence a *non-tree* comparator has
both inputs outside R, and M never visits it.
(b) No lo output is in R.
(c) Map each lead l in R that enters a comparator g to hi(g). This map makes R
an in-tree rooted at o_M (all M paths end there) whose leaves are the N input
leads. Each tree comparator is *binary* (both inputs in R) or *unary* (exactly
one input in R; its other input, written b(g), lies outside R). There are
exactly N-1 binary ones.

P_x is the set of tree comparators on the path of leaf x, and d(x) = |P_x|.
For a tree comparator v, A(v) is the path from v to the top, v included. "u is
an ancestor of v" means u is in A(v) and u != v.

### 3.2 Run decomposition
**Lemma B2.** Fix x != y and let c = lca(x,y), the first comparator common to
P_x and P_y. Then c is binary, and P_x, P_y share nothing below c. In run
(x,y), m climbs P_y as far as c and touches exactly the comparators of P_y
strictly below c. It does not meet M before c, meets M at c, and leaves on
lo(c). From that point M's path is A(c) minus c, which depends only on c, so
the rest of m's trajectory depends only on c. With T(c) the number of
comparators touched by m after c that M does not touch:

    |W(x,y)| = |P_x ∪ P_y| + T(c).

*Proof.* The two leaf paths first share a comparator c and enter it on
different leads. If they entered on the same lead, its source comparator would
be an earlier common comparator; the lead cannot be a network input, because
x != y. So c is binary. Below c, m is on the R-leads of P_y, where M is never
present (M is on P_x), so m always wins and follows P_y. At c both are present,
so M leaves on hi and m on lo. Any comparator touched by m after c is either on
A(c), where it meets M and is already counted in P_x, or untouched by M: the
comparators of P_x below c precede c in the DAG and so cannot follow it.
QED

### 3.3 Tails
*O-leads* are the leads outside R. After a meeting at a tree comparator v
(initially v = c), m sits on the O-lead lo(v), and M's remaining path is
A(v) minus v. Take an O-lead l carrying m that enters comparator g.
* If g is non-tree, its other input is outside R and so not M: m leaves on
  hi(g), an O-lead, and g is touched by m only.
* If g is a tree comparator, then by B1 g is unary and l = b(g). If g is in
  A(v), M is at g, m leaves on lo(g) (a free meeting), and v becomes g. If g
  is not in A(v), M is not at g: g follows v in the DAG, so it cannot lie on
  P_x before v. Then m leaves on hi(g), which is in R, and climbs the M-tree,
  touching only comparators that M does not touch, until it reaches the first
  comparator e of A(v) on its way up. There m meets M, leaves on lo(e), and v
  becomes e.

*F-forest.* Starting at lo(v), follow O-leads through non-tree comparators
(always via hi) until the walk reaches either an output, giving root(v) = END,
or the input b(d) of a unary tree comparator d, giving root(v) = d. Let dist(v)
be the number of non-tree comparators passed. Both depend only on the DAG.

**Lemma B3 (tail recursion).** Let v be any tree comparator at which m can be
knocked out ("used"; every binary comparator is used). Then:
* root(v) = END: the output reached is o_m (by correctness), and T(v) = dist(v);
* root(v) = d with d an ancestor of v: T(v) = dist(v) + T(d), and d is used;
* otherwise d is neither v nor a descendant of v, since either would close a
  directed cycle v -lo-> ... -> d -hi-> ... -> v. So d and v are incomparable,
  e = lca(d,v) is binary and a proper ancestor of both, and
  T(v) = dist(v) + 1 + climb(d,e) + T(e), where climb(d,e) is the number of
  tree comparators strictly between d and e.

*Proof.* This follows directly from the case analysis above. For the last
case: the first comparator of A(v) on the upward path from d is lca(d,v), and
it is binary by the argument in B2. The comparators passed between d and e lie
on d's side, which is not A(v), so they are touched by m only. The tail after a
meeting at e is T(e), because M's remaining path is then A(e) minus e, exactly
as when lca(x,y) = e. QED

**Lemma B4 (Kraft per root).** Fix a root r (END or a unary d). The O-leads
whose walk ends at r form an in-tree whose internal nodes are non-tree
comparators with at most two children each. For END, every used walk ends at
o_m. Hence sum over used v with root(v) = r of 2^{-dist(v)} <= 1.

### 3.4 The relaxation GM and Theorem B
A *GM instance* for (N, L) consists of:
* an unordered binary tree B with N leaves;
* unary nodes inserted on edges of B, including the edge above the root;
* for every merge, and optionally for unary nodes, a *spec* (root in {END} ∪
  unary nodes, dist >= 0) such that:
  - a root d is never the node itself or a descendant of it;
  - a node v whose root is an ancestor d is allowed only if d has a spec;
  - Kraft holds per root;
* such that, with T defined by the recursion of Lemma B3 (which only ever
  refers to proper ancestors, so it is well-founded), D(c) + T(c) <= L for
  every merge c. Here D(c) = max |P_x ∪ P_y| over pairs with lca c,
  = h(c) + (longest path below c on the left) + (longest path below c on the
  right), with h(c) = |A(c)|.

**Theorem B.** Every top-2-correct network with p2 <= L yields a GM instance
for (N, L) with the same costs. *Proof:* Lemmas B1-B4.

Therefore "no GM instance for (N, L)" implies P(2,N) > L. GM drops
acyclicity, and it keeps only Kraft rather than the exact F-tree shapes, so
it can only be weaker than the true problem, never unsound. GM without unary
nodes is exactly the "simple model" of Section 4.

### 3.5 The searches
* **Shapes:** all unordered binary trees with N leaves (983 for N = 13). GM is
  invariant under swapping children.
* **Unary placements.** Method C (`placements_pairbound`): every placement with
  D(c) <= L for all merges. This is trivially necessary because cost >= |P_x ∪
  P_y|. The enumeration is top-down with monotone pruning: adding unary nodes
  above a node only increases every D. It was checked to equal "enumerate with
  d(x) <= L, then filter by D(c) <= L" for all N <= 7, L <= 7. Method B: every
  placement with d(x) <= L - ceil(log2(N-1)) (corollary of Lemma A5).
* **Spec search** (`spec_search`): comparators are processed top-down, so
  ancestors come first. Node v picks a root and a target tau(v) = T(v). Its
  dist is tau(v) minus the offset prescribed by B3 (0, tau(d), or
  1 + climb + tau(e)), and must be >= 0. Its Kraft mass goes to that root.
  Merges need tau(c) <= L - D(c). The recursion only refers to proper
  ancestors, which are already fixed, so tau equals the true T. The search is
  exhaustive apart from three dominance rules:
  - **(R1)** Another node reads tau(v) only if v is the root of a node below it
    (v unary), or v = lca(d, v') for a grafting node v' and a unary d strictly
    below v. A merge with no unary node below it is therefore never read, and
    giving it the largest allowed tau, i.e. the smallest Kraft mass, is optimal.
  - **(R2)** A unary node with no comparator below it is never read, so leaving
    it without a spec is optimal.
  - **(R3)** For unary d, tau(d) > max_c (L - D(c)) cannot be used by any node
    (dist >= 0), so it is dominated by giving d no spec. tau(d) is enumerated in
    [0, max_c (L - D(c))].
  Kraft masses are exact integers in units of 2^-(L+1).

### 3.6 Validation of GM
* GM-pure (C) and GM (B) agree exactly with `bf` for N = 3..8, L = 2..8.
* The randomized extraction tests of Section 5 map random networks into GM and
  check the cost identity of Lemma B2/B3, Kraft per root (B4), the direct D(c)
  values, and that `spec_search` finds the instance feasible at L = p2.

## 4. Upper bounds: explicit networks (`sim.py`, `make_networks.py`, `networks.txt`)

**Simple model.** Take a binary M-tree B with no unary nodes. Each merge c is a
comparator of the two subtree maxima. For each merge c let
beta(c) = L - D(c), where D(c) = h(c) + height(left) + height(right) and h(root)
= 1. Then feed the N-1 lo outputs into an m-tree: a binary tree of extra
comparators in which lo(c) sits at depth <= beta(c). Such a tree exists iff
beta(c) >= 0 for all c and sum_c 2^{-beta(c)} <= 1 (Kraft). It is built by
pairing level by level from the deepest level, promoting an odd item. An
induction shows that at most ceil(2^l * S_l) items remain at each level l,
hence at most 1 at level 0. By B2/B3 every run then costs
|P_x ∪ P_y| + depth(lca) <= D(c) + beta(c) = L.

Exhaustive search over B gives these minimal levels of the simple model:
3, 4, 6, 6, 7, 7, 8, 8, 8, 9, 9 for N = 3..13 (no tree works at L-1). The trees
used:

| N | L | M-tree B | comparators |
|---|---|---|---|
| 9 | 8 | (0,(((0,0),(0,0)),((0,0),(0,0)))) | 15 |
| 10 | 8 | ((0,0),(((0,0),(0,0)),((0,0),(0,0)))) | 17 |
| 11 | 8 | (((0,0),(0,0)),((0,(0,0)),((0,0),(0,0)))) | 19 |
| 12 | 9 | ((0,0),(((0,0),(0,0)),((0,0),((0,0),(0,0))))) | 21 |
| 13 | 9 | (((0,0),(0,0)),(((0,0),(0,0)),(0,((0,0),(0,0))))) | 23 |

Every network was **simulated over all N(N-1) runs**: top-2 correct, and
max |W| = P(2,N) exactly. `networks.txt` lists every network for N = 3..13,
both in generalized form and untangled to standard form. In standard form each
comparator (i,j) has i < j, o_M = N-1 and o_m = N-2, and each was re-simulated.

Independently, `bf2 -k` found its own witnesses at (9,8), (10,8), (11,8) and
(12,9), with 19, 19, 19 and 25 comparators. All were simulated and are correct
(`check_witness.py`, `out/bf2_feas_*.txt`).

## 5. Randomized differential tests (`extract.py`, `near_opt_test.py`)

For each random top-2-correct network, `extract.analyse` simulates every run and
then checks:
1. the M-region, the tree/non-tree classification of B1, and the F-forest
   (every walk ends at an output or at b(d) of a unary tree comparator);
2. the cost identity |W(x,y)| = |P_x ∪ P_y| + T(lca(x,y)) for all x != y, with
   T computed by the recursion of B3;
3. Kraft per F-root over the nodes where m is actually knocked out (B4);
4. the fixed-x bound d(x) <= p2 - ceil(log2(N-1)) (corollary of A5);
5. that D(c) computed directly from the network equals D(c) of the
   reconstructed GM tree, and that `gm.spec_search` on the reconstructed
   (B, unary placement) is **feasible at L = p2** (N <= 7);
6. that every prefix state passes the bf2 Kraft test and P1 at L = p2.

Generators:
* (`extract.py`) a random prefix, then a bubble network, an odd-even
  transposition network, or a random simple-model network, then random
  insertions that keep top-2 correctness. N = 3..8; 2880 networks. Of these, 2784 (97%)
  contain unary tree comparators, 2261 (79%) grafting (m re-entering R) and
  2140 (74%) knock-outs at unary nodes.
* (`near_opt_test.py`) random **near-optimal** networks, p2 <= P+2, taken from
  the plain search with randomized move order (`bf2 -seed`). That search does
  not use the Kraft prune, so it has no bias towards the lemma under test.
  N = 4..8, 540 networks, of which 467 contain unary nodes and 401 grafting.

**All checks passed on every network.** Grafting and unary knock-outs are
common even in networks with p2 = P. They occur; they never beat the simple
model.

## 6. Points of residual doubt (honest assessment)

* For N = 12 and 13, every lower-bound route uses one non-trivial lemma: either
  the Kraft lemma (A5; Method A and the Hmax bound of Method B) or the
  structure theorem (B; Methods B and C). The two lemmas are independent and
  each has a short proof above. Each was also tested empirically, A5
  exhaustively at N <= 8 (`live.cpp`). Plain search without any lemma only
  reaches N = 9, where it confirms P(2,9) >= 8.
* GM is a relaxation, since acyclicity is dropped. That can only make it weaker;
  it cannot cause a false "infeasible". It still matched the true values for
  every N <= 13 tested.
* The dominance rules R1-R3 in `spec_search` are proved in 3.5. Separately,
  `spec_search` was found feasible at L = p2 on all extracted instances,
  including those with grafting.
* Dedup uses an exact 1024-bit key and full key comparison, so hash collisions
  cannot merge states. Imperfect canonical forms only cost time, and the
  variants `-lim 1` and `-all` give identical verdicts.
* I found no step I consider doubtful. The weakest link is ordinary software
  risk. Three implementations with different reductions (bf2 network search,
  GM-pure, GM with Hmax) and two independent plain brute forces (`bf.cpp`, and
  `bf2` without `-k`) agree on every overlapping case.

## 7. Files

* `sim.py`: simulator, simple model, network builder.
* `bf.cpp`: plain brute force, N <= 8.
* `bf2.cpp`: brute force, N <= 16; `-k` Kraft prune, `-all`, `-lim`, `-seed`.
* `live.cpp`: exhaustive soundness test of P1 and Kraft (live states).
* `gm.py`: GM model, placements (Hmax and pair-bound), spec search.
* `gm_pure2.py`: Method C driver.
* `test_pairbound.py`: validation of the pair-bound enumeration.
* `extract.py`, `near_opt_test.py`: randomized network-to-GM tests.
* `check_witness.py`: simulates bf2 witnesses.
* `make_networks.py`, `networks.txt`: explicit optimal networks.
* `out/`: logs.
