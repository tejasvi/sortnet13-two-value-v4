# Sorting networks on 13 inputs need at least 44 comparators: a Lean proof

This Lean 4 project proves that every sorting network on 13 channels has at least 44 comparators. It
formalizes the argument of T. S. Tomar, *Sorting networks on 13 inputs need at least 44
comparators* (Zenodo; all versions: doi:10.5281/zenodo.23453292): the two-value pruning lemma
`S(N) ≥ S(N-2) + P(2,N)` and the computation `P(2,13) ≥ 9`. The bound `S(11) ≥ 35` that the argument
uses is also proved in Lean, by checking Harder's certificate (J. Harder, doi:10.5281/zenodo.4108365)
with a checker whose soundness is proved in Lean.

## The statement

`S13/Defs.lean` uses only Lean's core library:

```lean
structure Comparator (n : Nat) where      -- min to channel i, max to channel j
  i : Fin n
  j : Fin n
  lt : i < j

def Comparator.apply (c : Comparator n) (v : Fin n → Nat) : Fin n → Nat :=
  fun k => if k = c.i then min (v c.i) (v c.j) else if k = c.j then max (v c.i) (v c.j) else v k

abbrev Network (n : Nat) := List (Comparator n)

def Network.eval (net : Network n) (v : Fin n → Nat) : Fin n → Nat :=
  net.foldl (fun w c => c.apply w) v

def Network.Sorts (net : Network n) : Prop :=
  ∀ v : Fin n → Nat, ∀ a b : Fin n, a ≤ b → net.eval v a ≤ net.eval v b

def MainStatement : Prop :=
  (∀ net : Network 11, net.Sorts → 35 ≤ net.length) →
    ∀ net : Network 13, net.Sorts → 44 ≤ net.length
```

The main results:

```lean
theorem Sortnet.S13_ge_44 : ∀ net : Network 13, net.Sorts → 44 ≤ net.length   -- S13/S11/Main.lean
theorem Sortnet.S11_ge_35 : ∀ net : Network 11, net.Sorts → 35 ≤ net.length   -- S13/S11/Main.lean
theorem Sortnet.main_theorem : MainStatement                                    -- S13/Main.lean
theorem Sortnet.main_theorem_01 (h11 : ∀ net : Network 11, net.Sorts01 → 35 ≤ net.length) :
    ∀ net : Network 13, net.Sorts01 → 44 ≤ net.length
```

`Sorts` asks for sorting of every vector of natural numbers; `S13/ZeroOne.lean` proves the 0-1
principle (`Network.sorts_iff_sorts01`).

**Two kinds of comparators.** The statement uses standard comparators `(i, j)` with `i < j` (min to
`i`, max to `j`): Knuth's model, in which the values of `S(n)` are stated. The quantities `W(x,y)` and
`P(2,n)` are defined for generalized comparators `(lo, hi)` in either order, because the paper defines
them for acyclic circuits, and pruning a standard network produces a generalized one.
`S13/Untangle.lean` proves that a generalized network that sorts with respect to a fixed order of its
outputs untangles into a standard sorting network of the same size. The proof of `S(11) ≥ 35` works
with comparators given by any pair of channels, as Harder's proof system does.

## Structure of the proof

**Part A: `S(13) ≥ S(11) + 9`** (`main_theorem`)

| file | content |
|---|---|
| `S13/Defs.lean` | standard networks, `Sorts`, `MainStatement`; generalized comparators, `runInput`, `W(x,y)` (`GNetwork.W`), `Top2Correct`, `P2AtLeast n L` |
| `S13Comp.lean` | the computation for `P(2,13) ≥ 9` (core Lean, native code): concrete states, the check `checkAll`, the untrusted search |
| `S13/FState.lean`, `S13/CheckSound.lean`, `S13/Runs.lean` | soundness of that check: Kraft potential, relabeling, orientation, `closure_sound`; `p2AtLeast_of_not_feasible` |
| `S13/P2_13.lean` | `fullCheck_13_8` (`native_decide`) and `P2_13 : P2AtLeast 13 9` |
| `S13/Untangle.lean`, `S13/Prune.lean` | untangling (Knuth, Exercise 5.3.4–16) and the two-value pruning lemma `prune` |
| `S13/Reduction.lean`, `S13/Main.lean` | `mainStatement_of_P2`, `main_theorem` |
| `S13/ZeroOne.lean` | the 0-1 principle |
| `S13/Validate.lean` | `p2_values`: `P(2,N) = 3, 4, 6, 6, 7, 7, 8, 8, 8, 9, 9` for `N = 3..13` |

**Part B: `S(11) ≥ 35`** (`S11_ge_35`)

| file | content |
|---|---|
| `S13/ZO/Basic.lean` | 0-1 vectors, comparators as arbitrary pairs, `Works`, lower bounds `LB V b`; subset, relabeling and inversion invariance; the successor rule `LB.succ` |
| `S13/ZO/Huffman.lean` | the Huffman rule `LB.of_huffman` (a Kraft potential), deletion of a constant channel `LB.of_delete'` |
| `S11Comp.lean` | the certificate checker (core Lean, native code): steps with bitmaps of their sets, successor and Huffman witnesses, parallel check `certOK` |
| `S13/S11/Codes.lean`, `S13/S11/Sound.lean` | codes of vectors; `witBound_sound`, `checkSucc_sound`, `checkHuff_sound`, `claims_of_check` |
| `S13/S11/Final.lean` | `certOK_sound` (a passed check gives `LB univ b`), `sorts_bound_of_LB` (bridge to `Network.Sorts`) |
| `S11Loader.lean`, `S11Data/` | the certificate as 33 string constants of 64 MiB, read at build time (FNV-1a pinned) |
| `S13/S11/Main.lean` | `certOK_harder11` (`native_decide`), `S11_ge_35`, `S13_ge_44` |
| `S13/S11/Small.lean`, `S11Small/` | the same pipeline on Harder's certificates for 5–10 channels: `S5_ge_9`, …, `S10_ge_29` |

Part B formalizes Harder's proof system rather than his Isabelle proof. A step of the certificate
claims that every network that works on a set `V` of 0-1 vectors (outputs of equal weight are equal)
has at least `b` comparators. A successor step gives, for each comparator that changes `V` other than
by relabeling, an earlier step whose set, relabeled and possibly inverted, lies inside the image of `V`
with bound `≥ b - 1`. A Huffman step gives, for each channel where `V` contains the vector with a single
`true` (or a single `false`), a bound `b_i` for the vectors of `V` with that value there, the channel
deleted; then `b ≤ ⌈log₂ Σ 2^{b_i}⌉` (Lean checks `2^b < 2 Σ 2^{b_i}`). The last step claims 35 for
width 11. `tools/convert.cpp` re-encodes the certificate (untrusted; the checker accepts any data).

## Trust base

```
'Sortnet.S13_ge_44' depends on axioms: [propext, Classical.choice, Quot.sound,
 certOK_harder11._native.native_decide.ax_1_1, fullCheck_13_8._native.native_decide.ax_1_1]
axiom Sortnet.fullCheck_13_8._native.native_decide.ax_1_1 : decide (Comp.fullCheck 13 8 = true) = true
axiom Sortnet.certOK_harder11._native.native_decide.ax_1_1 :
  decide (S11.certOK S11Data.theCert S11Data.certCount 2048 11 35 = true) = true
```

`native_decide` (Lean 4.35: `Lean.Meta.nativeEqTrue`) compiles and runs a Boolean and records the
result as an axiom. The proof therefore trusts Lean's kernel, and Lean's compiler, the C compiler and
the runtime on two computations. Search code, permutation decoding and step offsets only propose data
to the checks; an error in them can make a check fail but not succeed wrongly. The results depend on the
checking functions (`checkAll` in `S13Comp.lean`, `checkStep`/`certOK` in `S11Comp.lean`) and the parts
of the core library they call (arrays, `Nat`, `Std.HashSet`, `String` byte access, `Task`).

All other theorems use only the standard axioms: `prune`, `mainStatement_of_P2`, `checkAll_sound`,
`p2AtLeast_of_not_feasible`, `claims_of_check`, `certOK_sound` and `sorts_bound_of_LB` depend on
`[propext, Classical.choice, Quot.sound]`. Full output: `logs/axioms.txt`, `logs/axioms_s11.txt`.

## Building and checking

Requirements: [elan](https://github.com/leanprover/elan) (installs `leanprover/lean4:v4.35.0-rc3`
from `lean-toolchain`), a C++ compiler, `zstd`, Python 3, about 8 GB of disk for Mathlib and 16 GB for
the certificate data and its build products. Lake builds independent modules in parallel; elaborating
one certificate module takes about 2.5 GB of memory, so `scripts/build_s11_data.sh` builds them in
batches (all 33 at once take about 80 GB). The `native_decide` check of the certificate needs about
5 GB.

```
lake exe cache get                         # Mathlib build for the pinned revision
# Harder's certificate (1.2 GB), doi:10.5281/zenodo.4108365
curl -L -o proof_cert_11.bin.zst https://zenodo.org/api/records/4108365/files/proof_cert_11.bin.zst/content
scripts/s11_data.sh proof_cert_11.bin.zst  # writes data/s11/ (33 files, 2.2 GB)
scripts/build_s11_data.sh 8                # certificate modules, 8 at a time (about 20 GB)
lake build                                 # everything
lake build S13.Axioms S13.S11.Axioms       # print the axioms
```

`lake build S13.Main` builds Part A only and needs no certificate. The libraries `S13Comp`,
`S11Comp`, `S11Loader`, `S11Data` and `S11Small` are precompiled to shared libraries, so the
`native_decide` checks run native code; the 2.2 GB `S11Data` library is compiled with
`-mcmodel=medium`.

Timings on a shared x86-64 server with 384 hardware threads (load about 1.3 per thread):

| step | wall time | CPU time | memory |
|---|---|---|---|
| `S13.P2_13` (`native_decide`, 138,537 states, one thread) | 357 s | 357 s | 2.0 GB |
| `S13.Validate` (dominated by `N = 12`: 335,509 states) | 582 s | 607 s | 2.4 GB |
| 33 certificate modules (in parallel), native library | about 3 min | | 2.5 GB each |
| `S13.S11.Main` (`native_decide`, 12,659,079 steps, parallel tasks) | 73–108 s | 1.8 h | 4.7 GB |
| all other modules | under 20 s each | | |

A fresh clone on the same machine, following the instructions above with a local copy of the
certificate, took 107 s for the Mathlib cache, 75 s for `scripts/s11_data.sh`, 120 s for
`scripts/build_s11_data.sh 8` and 1,012 s for `lake build` (P2_13 332 s, Validate 658 s, S11 check
63 s), and printed the same axioms (`logs/fresh_clone_build_s11.log`).

## Validation

* Part A: `p2_values` (`S13/Validate.lean`); `crosscheck/CrossCheck.lean` with
  `scripts/crosscheck.py` compares the Lean definitions with the clean-room programs of the paper's
  supplement on 117,200 networks (no mismatch, `logs/crosscheck.log`).
* Part B: the certificate is Harder's published file (MD5 of the `.zst`:
  `2847374c6bab1260c9771d6fafe65f44`; SHA-256 of the uncompressed file:
  `7fe9f5cd694714bf83da0bcab162a290eb076ad4257265507a74cea8fab85b7e`). Certificates for 5 to 10 channels, produced by Harder's tool
  (`jix/sortnetopt` at commit `0b5d09c`), give `S(5) ≥ 9`, `S(6) ≥ 12`, `S(7) ≥ 16`, `S(8) ≥ 19`,
  `S(9) ≥ 25` and `S(10) ≥ 29` in Lean (`S13/S11/Small.lean`). `bench/S11Neg.lean` corrupts single
  steps of the 11-channel certificate (bound 35 → 36, a permutation, a witness id, a missing witness,
  a bound + 1, an invalid kind): all 32 corrupted steps are rejected (`logs/s11_negative_controls.log`).
* `bench/Bench.lean`, `bench/S11Bench.lean`: native executables that run the checks outside Lean.

## License

Code under the Apache License 2.0.
