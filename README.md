# Sorting networks on 13 inputs need at least 44 comparators: programs and logs (version 4)

Programs, logs and independent checks for the paper of the same title by Tejasvi Singh Tomar (independent
researcher, ORCID 0000-0003-4668-3639).

* Paper (version 4): https://doi.org/10.5281/zenodo.23486690
* This repository, archived: https://doi.org/10.5281/zenodo.23486691
* All versions of the paper and of this repository: https://doi.org/10.5281/zenodo.23453292 and
  https://doi.org/10.5281/zenodo.23453294

## What the paper proves

Let S(N) be the least number of comparators in a sorting network on N inputs. Deleting the comparators met by
the largest and the second largest input leaves a sorting network on N - 2 inputs, so
S(N) >= S(N-2) + P(2,N), where P(2,N) is the least possible worst-case number of comparators met by these two
values (Lemma 2.2 of the paper). The paper proves

* P(2,N) = ceil(log2 F(N)) for 3 <= N <= 32, where F is Van Voorhis's function (Theorem 1.2);
* S(13) >= 44, from P(2,13) = 9 and Harder's S(11) = 35 (Theorem 1.1);
* S(N) >= 48, 53, 57, 63, 68, 73, 78, 84, 89, 95, 100, 106, 111, 117, 123, 129, 135, 141, 147 for
  N = 14, ..., 32 (Corollary 1.3);
* S(13) >= 44 in Lean 4, including S(11) >= 35 (Section 7).

The upper bound P(2,N) <= ceil(log2 F(N)) is an explicit network (Proposition 2.5). The lower bound reduces,
by a structure theorem for networks that deliver the two largest values to fixed outputs (Section 3), to a
finite search over configurations (Section 4). The search finds no configuration of cost
L = ceil(log2 F(N)) - 1 for N = 3, ..., 13, 17, 21 and 28, and the monotonicity of P(2,N) in N (Lemma 2.3)
covers the other N <= 32.

## Layout

| path | contents |
|---|---|
| `src/abs5.cpp` | the search of Section 4.1, steps (S1)-(S6) |
| `src/abs9.cpp` | `abs5` plus the tests (P1)-(P3) of Section 4.2; optional arguments `shard nshards` |
| `src/abs9f.cpp` | `abs9` with the representative test, (S3) during the enumeration, and splitting (Section 4.4); used at N = 28 |
| `src/abs9g.cpp` | `abs9f` with the symmetry test of Section 4.3 and up to five levels of splitting of the depth-first search; used for 17 shapes at N = 28 |
| `src/earlier/` | `abs9m.cpp` and `abs9c.cpp`, the variants of `abs9` used in the earlier run at N = 28, and `abs9g_r1.cpp` to `abs9g_r4.cpp`, earlier revisions of `abs9g` that wrote some of the logs (`scripts/n28/README.md`) |
| `src/vvF.py` | Van Voorhis's function F(N), N <= 32 |
| `src/vv_construct.py` | the network of Proposition 2.5 for one N, simulated on all N(N-1) runs |
| `scripts/run_searches.sh` | re-runs every computation of the paper except N = 28, and writes `logs/search/`, `logs/F.txt`, `logs/upper.txt` |
| `scripts/check_logs.py` | checks the logs of `logs/search/` and prints the numbers quoted in the paper |
| `scripts/n28/` | the scripts that ran the search at N = 28 on the compute servers |
| `scripts/check_n28.py` | checks the logs of the search at N = 28 and of the earlier run, and prints the numbers quoted in the paper |
| `logs/search/` | one log per run of `abs5` or `abs9` (Table 2 for N <= 21, and the first two rows of Table 3) |
| `logs/n28/` | the logs of the search at N = 28 (Table 2) |
| `logs/n28_earlier/` | the logs of the earlier run at N = 28 (last row of Table 3) |
| `logs/F.txt`, `logs/upper.txt` | F(N) and the simulated upper-bound networks, N <= 32 |
| `verification/` | the independent checks of Table 3; see `verification/README.md` |
| `lean/` | the Lean 4 proof of Section 7 that S(13) >= 44 (`Sortnet.S13_ge_44`), including S(11) >= 35 from Harder's certificate, with two computations evaluated by `native_decide`; see `lean/README.md` |
| `lean_kernel/` | the Lean 4 proof of Section 7 that S(11) >= 35 implies S(13) >= 44, checked by Lean's kernel with the standard axioms only; see `lean_kernel/README.md` |

## Running

A C++17 compiler and Python 3. From the root of the repository:

```
scripts/run_searches.sh          # about 7 minutes on one core; most of it is abs9 at N = 9, L = 8
python3 -I scripts/check_logs.py
python3 -I scripts/check_n28.py  # about a minute; recomputes the 62,641 tree shapes for N = 28
verification/n28/run_checks.sh   # the checks of abs9f and abs9g, about 15 minutes
```

`check_logs.py` verifies that every log of `logs/search/` is complete, that no run at L = ceil(log2 F(N)) - 1
reports a feasible configuration, that no run reports a mismatch between the cost formula and the simulation of
a rebuilt network, that `abs5` and `abs9` agree wherever both were run, and that the upper-bound networks have
cost ceil(log2 F(N)).

Each search program prints one line per tree shape, or per share of a tree shape in a split run,
`shape <canonical string> [labels] configs=<skeletons that pass (S3) and (P1)> feasible=<feasible configurations> nodes=<search nodes>`,
and, when it finishes, `TOTAL configs=... leaves=<complete assignments> feasible=... simfail=<mismatches in (S6)>`.
A "skeleton" is a tree with a number of pass-throughs on each edge (Definition 3.7 of the paper).

## The search at N = 28

The search at N = 28, L = 11 needs far more computation than the other runs (Section 5 of the paper). It ran on
several 384-thread x86-64 servers, with the scripts in `scripts/n28/`:

* `logs/n28/shards/`: `abs9f 28 11 s 4096` for s = 0, ..., 4095 with `SKIPFILE=logs/n28/skip119.txt`. Process
  s takes the tree shapes whose index is s modulo 4096, except the 119 shapes of `skip119.txt`
  (`scripts/n28/shards.sh`).
* `logs/n28/split102/`: 102 of these 119 shapes, each by `abs9f` in 64 shares, `CFGSPLIT=i/64 SPLITLEVEL=10`
  (`scripts/n28/split102.sh`).
* `logs/n28/sym17/`: the other 17 shapes by `abs9g`, in the same 64 shares. One share of each shape (two for one
  shape) is split again (`CFGSPLIT2=j/64 SPLITLEVEL2=16`), 33 of these sub-shares have their depth-first search
  split into 40 shares at depth 5 (`DFSSPLIT=m/40 DFSSPLITDEPTH=5`), and where needed these are split further:
  into 8 shares at depth 10 or 64 at depth 12 (`DFSSPLIT2`), then 4 at depth 14 or 32 at depth 16 (`DFSSPLIT3`),
  16 at depth 18 (`DFSSPLIT4`), and 8 at depth 20, 64 at depth 22 or 512 at depth 24 (`DFSSPLIT5`). The log names
  `y_`, `z_`, `w_`, `v_`, `t_`, `q_` and `p_` tell the scripts apart (`scripts/n28/README.md`).

A shape with index i is the i-th shape in the order in which the programs enumerate them (`shapes()` in the
source; `check_n28.py` recomputes the list). Each file in `logs/n28/` concatenates the logs of one group of
processes, each log preceded by a line `==> <log name> <==` and ending with `EXIT <exit status>`. Logs of
processes that were stopped before the end, because the same share had been completed in another way, contain no
result line and are not included.

`check_n28.py` checks that each log is complete, that no line reports a feasible configuration or a mismatch, that
the logs of `abs9g` ran with the symmetry test, that the shares of every split are all present, and that the
three groups cover each of the 62,641 shapes exactly once. Its output is `verification/n28/check_n28.out`; the
totals over the logs that it uses for the coverage are 262,417,641,559 skeletons, 30,972,138,194,473 search nodes and 12,416,681,168,846
complete assignments, with no feasible configuration. It also reads the earlier run in `logs/n28_earlier/`
(Section 6 of the paper): parts 1-6 with `abs5`, `abs9` (48 processes), `abs9m` (24 and 360 processes) and
`abs9c` (7,280 shards and 629 single shapes), each part skipping the shapes that earlier parts had finished. Its
logs contain a result line for each of the 62,522 shapes outside `skip119.txt`; processes stopped before the end
are included as they are. The script checks that it reports no feasible configuration and that each of its result
lines from `abs9`, `abs9m` and `abs9c` has the same number of skeletons as the run of `abs9f` in
`logs/n28/shards/`.

## The formal proof

Two Lean 4 projects (Lean v4.35.0-rc3 with Mathlib, pinned in `lean-toolchain` and `lake-manifest.json`). In
both, the pruning lemma is proved in Lean and P(2,13) >= 9 is reduced to a check that Lean proves sound.

* `lean/` proves `Sortnet.S13_ge_44 : ∀ net : Network 13, net.Sorts → 44 ≤ net.length`, with no hypothesis.
  It proves S(11) >= 35 (`Sortnet.S11_ge_35`) by checking Harder's published certificate
  (doi:10.5281/zenodo.4108365) with a checker whose soundness is proved in Lean. The check of P(2,13) >= 9 and
  the check of the certificate run as native code (`native_decide`), which adds one axiom for each:
  `#print axioms Sortnet.S13_ge_44` gives `[propext, Classical.choice, Quot.sound,
  certOK_harder11._native.native_decide.ax_1_1, fullCheck_13_8._native.native_decide.ax_1_1]`
  (`lean/logs/axioms_s11.txt`). The certificate data (2.2 GB, written to `lean/data/s11/`) are not in this
  repository; `scripts/s11_data.sh` makes them from Harder's file, whose SHA-256 is checked first:

  ```
  cd lean
  lake exe cache get
  curl -L -o proof_cert_11.bin.zst https://zenodo.org/api/records/4108365/files/proof_cert_11.bin.zst/content
  echo "95da7e06ebef17bf76a50ae0e9d19d56cf87e0ec9e61b941528dc2cf05521fef  proof_cert_11.bin.zst" | sha256sum -c
  scripts/s11_data.sh proof_cert_11.bin.zst   # prints the SHA-256 of the uncompressed certificate:
                                              # 7fe9f5cd694714bf83da0bcab162a290eb076ad4257265507a74cea8fab85b7e
  scripts/build_s11_data.sh 8                 # the 33 certificate modules, 8 at a time
  lake build
  lake build S13.Axioms S13.S11.Axioms        # prints the axioms
  ```

  From a fresh clone on a 384-thread x86-64 server, the four build steps took 107 s, 75 s, 120 s and 1,012 s of
  wall clock time; the `lake build` used 2.1 hours of processor time and at most 4.6 GiB of memory per process
  (`lean/logs/fresh_clone_build_s11.log`). `lake build S13.Main` builds only the conditional theorem
  `Sortnet.main_theorem` and needs no certificate.
* `lean_kernel/` proves `S13K.main_theorem : Sortnet.MainStatement`: if every sorting network on 11 channels has
  at least 35 comparators, then every sorting network on 13 channels has at least 44. Lean's kernel evaluates the
  check, on a certificate produced by an untrusted program, so `S13K.main_theorem` depends only on the axioms
  `propext`, `Classical.choice` and `Quot.sound`. The certificate
  (`data/keys.txt` and `data/c/*.txt`; from `lean_kernel/`, `LC_ALL=C cat data/keys.txt data/c/c*.txt | sha256sum`
  gives `092f8a343d02be3e1980cfc2da78343da9d907ba1f55ef076437060bde8fd403`) is regenerated by
  `ops/make_data.sh` with the generator `gen/certgen.cpp`; the kernel check does not trust the generator or the
  data, and `negctl/` holds seven corrupted certificates, all rejected. Build: `lake exe cache get`, then `LEAN_NUM_THREADS=J lake build` with J parallel
  jobs of about 4.5 GB each, then `lake env lean ops/Axioms.lean`. With J = 120 on a 384-thread x86-64
  server the build took 2 min 56 s of wall clock time and 4.96 hours of processor time.

The two projects share nine source files byte for byte, among them the definitions and the pruning lemma:
`lean_kernel/` copied them from commit `a07e626` of `lean/`, and they are unchanged in the `lean/` of this
repository (`lean_kernel/VENDORED_FROM_s13.sha256`). Section 7 of the paper describes the proofs and their trust
base.

## Notes on the code

* In `src/abs9.cpp` the test `depOf[s]==-7` in `lbRoute` and the variables `lbBad` and `isDead` are unused: dead
  sources count as 0 in the partial costs (P3), as the paper states. The same holds in `abs9f.cpp` and
  `abs9g.cpp`.
* `src/vv_construct.py` builds the tree of comparators for the second maximum by merging the two smallest
  values of a(c) first, which gives depth at most ceil(log2 F(N)) - a(c) for each lo(c), as Lemma 2.4(c) does.
* The source files of `src/` are the files that produced the logs.
* `abs9f` and `abs9g` read the split options from the environment: `CFGSPLIT=i/P` at level `SPLITLEVEL`
  (default 10) and `CFGSPLIT2=j/Q` at level `SPLITLEVEL2` (default 16) split the enumeration of the numbers k(v);
  `DFSSPLIT=m/R` at depth `DFSSPLITDEPTH` (default 3) and `DFSSPLIT2=m2/R2` at depth `DFSSPLITDEPTH2` (default 8)
  split the depth-first search, and `abs9g` also has `DFSSPLIT3` to `DFSSPLIT5` (with `DFSSPLITDEPTH3` to
  `DFSSPLITDEPTH5`), each splitting the shares of the level above at a deeper depth. The labels `part=`, `sub=`,
  `dsplit=` (with `depth=`) and `dsplit2=` to `dsplit5=` (with `depth2=` to `depth5=`) in a result line record
  them. A split of the depth-first search covers the search in any case; its shares are disjoint when every
  configuration has more sources than the split depth, which holds at N = 28 (at least 27 sources, split depths
  at most 24). `abs9g` prints `SYMBREAK 1` after the first line; `SYMBREAK=0`
  turns the symmetry test off, and `SBORBIT=1` prints each feasible assignment as the least member of its class
  (used only in `verification/n28/`).

## Licence

The programs are under the Apache License 2.0 (`LICENSE`). The logs and the documentation are under CC BY 4.0
(`LICENSE-CC-BY-4.0.txt`).

## Citation

```
@misc{Tomar2026S13,
  author    = {Tomar, Tejasvi Singh},
  title     = {Sorting networks on 13 inputs need at least 44 comparators},
  year      = {2026},
  publisher = {Zenodo},
  version   = {4},
  doi       = {10.5281/zenodo.23486690}
}
```
