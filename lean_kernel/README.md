# Sorting networks on 13 inputs need at least 44 comparators: a kernel-checked Lean proof

This Lean 4 project proves that every sorting network on 13 channels has at least 44 comparators,
assuming Harder's bound `S(11) ≥ 35` as an explicit hypothesis. Every step, including the computation
`P(2,13) ≥ 9`, is checked by Lean's kernel: the proof uses only the axioms `propext`,
`Classical.choice` and `Quot.sound`, and no native code (`native_decide`, `Lean.ofReduceBool`).

It proves the same proposition as the Lean formalization that runs the computation by `native_decide`
(`lean/` in the release repository, commit `a07e626`, below "the native project"), and reuses its definitions and
its proofs that do not depend on native code. Only the computation is new: a certificate produced by
an untrusted program, and a checker that Lean's kernel evaluates.

## The statement

`S13/Defs.lean` (core Lean only, byte-identical to the native project) defines standard comparator
networks (a comparator `(i, j)` with `i < j` puts the minimum on channel `i` and the maximum on `j`),
`Network.Sorts` (sorts every input vector of natural numbers) and

```lean
def Sortnet.MainStatement : Prop :=
  (∀ net : Network 11, net.Sorts → 35 ≤ net.length) →
    ∀ net : Network 13, net.Sorts → 44 ≤ net.length
```

`S13Kernel/Main.lean` proves

```lean
theorem S13K.main_theorem : Sortnet.MainStatement
theorem S13K.main_theorem_01 (h11 : ∀ net : Sortnet.Network 11, net.Sorts01 → 35 ≤ net.length) :
    ∀ net : Sortnet.Network 13, net.Sorts01 → 44 ≤ net.length
theorem S13K.p2_13 : Sortnet.P2AtLeast 13 9
```

`main_theorem_01` is the same result with sorting defined on 0-1 inputs (0-1 principle,
`S13/ZeroOne.lean`). How the hypothesis follows from Harder's Isabelle-verified certificate checker is
explained in the README of the native project.

## Axioms

`lake env lean ops/Axioms.lean` (log: `logs/run2/axioms.txt`):

```
'S13K.main_theorem' depends on axioms: [propext, Classical.choice, Quot.sound]
'S13K.main_theorem_01' depends on axioms: [propext, Classical.choice, Quot.sound]
'S13K.p2_13' depends on axioms: [propext, Classical.choice, Quot.sound]
'S13K.not_feasible' depends on axioms: [propext, Classical.choice, Quot.sound]
```

The proof trusts Lean's kernel and the hypothesis `S(11) ≥ 35`. The certificate generator, the data
files and the commands that load them are not trusted: they only supply terms, and the kernel checks
every claim made about them.

## Structure

| file | content |
|---|---|
| `S13/Defs.lean`, `S13Comp.lean`, `S13/{FState,CheckSound,Runs,Untangle,Prune,Reduction,ZeroOne}.lean` | verbatim copies from the native project (`VENDORED_FROM_s13.sha256`): definitions, states and the potential `Phi`, `closure_sound`, `p2AtLeast_of_not_feasible`, two-value pruning, untangling, `mainStatement_of_P2`, the 0-1 principle. None of them uses native code. `S13/P2_13.lean` and `S13/Main.lean`, which do, are not part of this project. |
| `S13Kernel/Check.lean` | the checker, core Lean only, written for kernel evaluation |
| `S13Kernel/Sound.lean` | its soundness: `chkState_sound`, `not_feasible_of_cover` |
| `S13Kernel/Load.lean` | elaboration-time commands `load_keys`, `load_certs` that turn the data files into literal terms |
| `S13Kernel/Data/Keys.lean` | the 99,736 states of the certificate (`data/keys.txt`) as a trie `S`, and `N = 99736` |
| `S13Kernel/Chunks/C00000.lean` … `C01101.lean` | 1,102 theorems `chk : chkChunk S N lo len ces = true`, each proved by `decide +kernel`, with the certificate lists `ces` of states `lo … lo+len-1` (`data/c/*.txt`) |
| `S13Kernel/Agg/L1_*.lean`, `L2_0000.lean`, `S13Kernel/All.lean` | combine the chunk theorems into `all_ok : RangeOK S N 0 99736` |
| `S13Kernel/Main.lean` | `start_ok` (key 0 is the start state, `decide +kernel`), `not_feasible`, `p2_13`, `main_theorem`, `main_theorem_01` |
| `gen/certgen.cpp`, `gen/mkmods.py`, `ops/make_data.sh` | the untrusted certificate generator and the generator of the data files and of the chunk and aggregation modules |
| `negctl/` | negative controls (corrupted certificates that must be rejected) |
| `ops/` | build script with memory monitor (`run_build.sh`, `memmon.py`), `Axioms.lean` |
| `logs/run2/` | logs of the measured build (final sources), axioms, negative controls |

## The computation

A *state* records, for each pair of channels `(p, q)`, the largest number of comparators met so far by
a run with the largest value on `p` and the second largest on `q`, or no entry (method A of the
paper's clean-room verification; `S13/FState.lean`). The native project proves `closure_sound`: if a
set `H` of states contains no goal and every comparator `(a, b)`, `a < b`, takes each state of `H` to
the same state, or to a state whose Kraft potential exceeds `2^8`, or to a state with an injective
relabeling in `H`, then no state of `H` can be completed by a network with all `|W(x,y)| ≤ 8`.

Certificate. `gen/certgen.cpp` (breadth-first search with the relabeling by colour refinement of
`bf2.cpp`) produces 99,736 states. Each state is a natural number (*key*) with a 4-bit field per pair
`(p, q)`; the low 64 bits hold a salt, because the kernel hashes numerals by their low 64 bits. For
each state and each comparator `(a, b)` whose child is neither unchanged nor pruned by the potential,
the certificate gives `(16a+b, σ, σ⁻¹, j)`: the child relabeled by `σ` is state number `j`. In total the
check examines 7,779,408 children: 275,115 unchanged, 6,396,523 pruned by the potential, 1,107,770
matched to a state of the list.

Checker (`S13Kernel/Check.lean`). For each state and each comparator `(a, b)`, `a < b < 13`, `chkPair`
looks up the certificate entry. If there is none, the comparator must meet no run (`untK`) or the
child's potential must exceed 256 (`phiInc`, computed from the row sums of the parent: rows other than
`a` and `b` change in two entries, row `b` is recomputed, row `a` is empty). If there is an entry, `σ`
must map the channels below 13 injectively into themselves (`validK`, with the left inverse `σ⁻¹`), and
every field `(p, q)` of key `j` must equal entry `(σ p, σ q)` of the child (`isoK`). `chkState` also
requires two nonempty entries, so that the state is not a goal. `RangeOK S N 0 N` says that every key
of the trie passes `chkState` with some certificate list.

Soundness (`S13Kernel/Sound.lean`): `entryF` computes the native project's `fstep`
(`denF_entryF`); `phiInc` equals the potential of the child up to replacing `R` by a lower bound
`npow` (`rowOther_eq`, `rowHi_eq`, `npow_le_R`, `phiInc_le`); `untK`, `isoK`, `validK`, `cntK` and
`startK` mean what they should. `not_feasible_of_cover` applies `closure_sound` to
`H = {den13 (getK S j) : j < N}`. Kernel evaluation is made fast by explicit `Nat.rec`/`List.rec`
loops, bare `Bool.rec` on `Nat.beq`/`Nat.ble` instead of `if` on `Decidable` instances, direct calls
of `Nat.add`, `Nat.mul`, ..., and the incremental potential.

## Building

Requirements: [elan](https://github.com/leanprover/elan) (installs `leanprover/lean4:v4.35.0-rc3`
from `lean-toolchain`), git, about 8 GB of disk for Mathlib, and about 4.5 GB of memory per parallel
job.

```
lake exe cache get                                   # Mathlib build for the pinned revision
LEAN_NUM_THREADS=J lake build                        # J parallel jobs, J ≤ (free memory)/4.5 GB
lake env lean ops/Axioms.lean                        # prints the axioms above
```

`LEAN_NUM_THREADS` bounds the number of modules that Lake builds at once (Lake has no `-j` option;
without it Lake starts one job per core). `ops/run_build.sh J` does the same and also records
timings, the toolchain, source hashes and the peak memory of every module in `logs/`; it uses the `lake`
on the `PATH`, or the toolchain directory given in `LEAN_BIN`. The data files and the generated modules are part of the
repository; `ops/make_data.sh` regenerates them from scratch (C++ compiler and Python 3 needed, about
50 s), and changes no file. `negctl/run_negctl.sh` runs the negative controls.

## Certificate

The certificate is `data/keys.txt` (99,736 keys, one per line) and `data/c/c00000.txt` …
`c01101.txt` (one line of certificate entries per key; concatenated in file order they form the
generator's certificate file). Its hashes:

```
sha256sum data/keys.txt
# 1302e09be5298e2948a64d4289de719acfe064213bdc70f1285c70b05229297c
LC_ALL=C cat data/c/c*.txt | sha256sum
# 0e6e38fa277c7de1edbea3607e3bac98c9d5493aa7cfff73677b991319f1a349
LC_ALL=C cat data/keys.txt data/c/c*.txt | sha256sum
# 092f8a343d02be3e1980cfc2da78343da9d907ba1f55ef076437060bde8fd403
```

`ops/make_data.sh` recompiles the generator, writes `gen/keys_13_8.txt` and `gen/certs_13_8.txt`, which
have the first two hashes, and leaves `data/` and all generated Lean modules unchanged. The kernel
check does not trust the generator: a wrong or missing entry makes a chunk theorem fail (see the
negative controls below).

## Measurements

A 384-thread x86-64 server with 708 GB of memory (Linux), Lean
`v4.35.0-rc3` (commit `470d5ce`), Mathlib `c55e6e78` prebuilt; `ops/run_build.sh 120` from an empty
`.lake/build` (logs in `logs/run2/`, source hashes in `sources.sha256`):

| quantity | value |
|---|---|
| `LEAN_NUM_THREADS=120 lake build S13Kernel.Main` | 2 min 56 s wall clock |
| CPU time | 17,385 s user + 470 s system (4.96 h) |
| 1,102 chunk modules | 12–20 s each (median 16 s), 17,303 s in total |
| peak memory per process | 4.21 GiB (chunk median 3.78 GiB; 1.5 GiB of it is the `import Lean` of the loader) |
| `S13Kernel.Data.Keys` (trie of 99,736 keys) | 7.8 s |
| all other modules | under 2 s each |
| smallest free memory during the build | 443 GB |

A first build of the same proof (identical except for an unused import in `Check.lean`) took
2 min 53 s and 17,403 s of CPU (`logs/run1/`). A fresh clone of the repository (with the
Lean sources and data of this version; Mathlib packages copied in place of `lake exe cache get`, since
the machine had no internet access) built on the same machine in 2 min 55 s (17,386 s user) with the
same axioms, and rejected all negative controls (`logs/fresh_clone/`).

## Negative controls

`negctl/run_negctl.sh` (log `logs/run2/negctl.txt`): each control changes one item and the
kernel must reject it. All seven are rejected (`decide` evaluates the claim to `false`):

| control | change |
|---|---|
| `NegA_target` | target index of a certificate entry + 1 |
| `NegB1_sigma` | `σ(0)`, `σ(1)` swapped, inverse unchanged |
| `NegB2_sigma_consistent` | `σ` composed with the transposition (0 2), inverse updated (the transposition (0 1) is an automorphism of that target and is accepted, as it should be) |
| `NegC_drop` | a certificate entry removed |
| `NegG_len` | chunk length 82 claimed instead of 81 |
| `NegD_target_key` | one field of a target key changed |
| `NegE_start_key` | one field of key 0 (the start state) changed |

## The hypothesis `S(11) ≥ 35`

The hypothesis stays explicit. A kernel-only replay of Harder's certificate (`proof_cert_11.bin`,
3.07 GB, 1.25 GB compressed, 12.66M steps, mostly at widths 8 to 10) was estimated but not attempted:

* Computation. Each step applies up to 55 comparators to a set of 0-1 vectors and tests a permuted
  (and possibly inverted) earlier set for inclusion. With vector sets as `2^w`-bit numbers, a comparator
  is a few big-number operations and a permutation about 50; at the measured 3 to 5 µs per kernel
  operation this is 10 to 20 ms per step, so roughly 35 to 200 CPU hours in total, plus the loading of
  about 3 GB of literal data split over tens of thousands of modules.
* Formalization. The soundness of the checker would have to be ported from Isabelle/HOL
  (`Checker.thy`, `Huffman.thy`, `Sorting_Network.thy`: 4,219 lines) to Lean, together with the proofs
  that the bitset encodings compute it. This, not the computation, is the main cost.

## License

Code under the Apache License 2.0. The files listed in `VENDORED_FROM_s13.sha256` are copies from the
native project, under the same license.
