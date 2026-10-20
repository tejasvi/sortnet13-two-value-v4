# Independent checks (Table 3 of the paper)

Two sets of programs, written separately from `src/`, give the rows of Table 3 up to the tests of the two lower
bounds:

* `cleanroom/`: a second determination of P(2,N) for N <= 13, written from the definitions of Section 2 of the
  paper without using `src/` or the model of Section 3. Its notes, `cleanroom/METHOD.md`, describe methods A, B
  and C, prove the lemmas they rest on (a Kraft inequality over runs, Lemma A5, and a structure theorem for a
  relaxed tree model, Theorem B), and record their validation.
* `audit/`: programs that test `src/abs5.cpp` and its model. `audit/abs5_core.h` is `src/abs5.cpp` without
  `main`, plus filters that force the search onto a given configuration; `audit/audit.cpp` uses it to run
  networks through the code of `abs5`.

The rows of Table 3 and their files:

| row of Table 3 | programs | logs |
|---|---|---|
| `abs9` against `abs5` | `src/`, `scripts/run_searches.sh` | `logs/search/`, checked by `scripts/check_logs.py` |
| simulation (S6) of feasible configurations | step (S6) of `src/abs5.cpp` and `src/abs9.cpp` | `simfail=0` in the logs `logs/search/*_L<P>.log` with L = P(2,N) |
| networks of Proposition 2.5 | `src/vv_construct.py` | `logs/upper.txt` |
| method A | `cleanroom/bf2.cpp` with `-k`, run by `cleanroom/rerun_table.sh`; witnesses simulated by `cleanroom/check_witnesses.sh` (which uses `cleanroom/check_witness.py`) | `cleanroom/out/table_cleanroom.txt`; witnesses `cleanroom/out/table_cleanroom.txt` (N <= 7) and `cleanroom/out/bf2_feas_*.txt` (8 <= N <= 12); simulation `cleanroom/out/check_witnesses.txt` |
| method A without the Kraft prune | `cleanroom/bf2.cpp` without `-k` | `cleanroom/out/bf2_plain_9_7.txt` |
| methods B and C | `cleanroom/gm.py` (B), `cleanroom/gm_pure2.py` (C), run by `cleanroom/rerun_table.sh` | `cleanroom/out/table_cleanroom.txt` |
| test of the prunes of method A | `cleanroom/live.cpp` | `cleanroom/out/live_8.txt` |
| tests of the relaxed tree model | `cleanroom/extract.py`, `cleanroom/near_opt_test.py` | `cleanroom/out/extract_*.txt` (2,880 networks), `cleanroom/out/nearopt_*.txt` (540 networks) |
| one integer program per skeleton | `audit/milpcheck.py` (HiGHS through `highspy`), `audit/abs5_percfg.cpp`, `audit/cmpcfg.sh`, `audit/compare_milp.sh` | `audit/runs/milp_*.txt`, `audit/runs/milpcfg_*.txt`, `audit/runs/abs5cfg_*.txt`, `audit/runs/milp_nodedup_*.txt`; summary `audit/runs/compare_milp_abs5.txt` |
| networks mapped into the model | `audit/audit.cpp` with `audit/abs5_core.h`; `audit/runs/launch1.sh` | `audit/runs/{exh,randmin,sortmin,sa_P,sa_P1}_*.txt` (29 files, 4,464,896 networks) |
| search over standard networks without the model | `audit/p2canon.cpp`, `audit/run_p2canon.sh` | `audit/runs/p2canon_rerun_*.txt` |
| tests of the two lower bounds and the symmetry reduction of that search | `audit/bftest/bflemmas.cpp`, `audit/bftest/run.sh`, input `audit/bftest/pool.txt` | `audit/bftest/lemmas.log` |
| `abs9f` against `abs9` | `n28/run_checks.sh`, `n28/compare_abs9f.py` | `n28/abs9f_vs_abs9/`; summary `n28/compare_abs9f.out` |
| `abs9g` against `abs9f` | `n28/run_checks.sh`, `n28/compare_abs9g.py` | `n28/abs9g/` (`s0_*`, `s1_*`: without and with the symmetry test; `o0_*`, `o1_*`: classes of feasible assignments); summary `n28/compare_abs9g.out` |
| split runs against unsplit runs | `n28/check_splits.py` | `n28/check_splits.out` |
| earlier run at N = 28 | `scripts/check_n28.py` | `logs/n28_earlier/`; summary `n28/check_n28.out` |

Notes.

* `cleanroom/rerun_table.sh` writes its results to standard output; it was run as
  `cleanroom/rerun_table.sh > cleanroom/out/table_cleanroom.txt 2> cleanroom/out/table_cleanroom.err`.
* The random-network logs of the audit were written by `audit/audit.cpp` in the modes `exh` (all standard
  networks up to a given length), `randmin`, `sortmin` and `sa` (random, minimized and annealed networks); the
  arguments are in the file names and in `audit/runs/launch1.sh`. Each log ends with the number of networks
  tested and the number of failures. 3,972,276 of the 4,464,896 networks are the exhaustive run on 4 inputs
  (`exh_4_9.txt`); the other files cover 5 <= N <= 11.
* `audit/milpcheck.py` encodes, for one skeleton, the choice of roots and depths with Kraft equality per root,
  acyclicity by ordering variables, and the cost bounds. `milp_nodedup_*` repeat the check over ordered trees,
  without identifying automorphic skeletons. The integer programs count a few more skeletons than `abs5` at (3,4)
  and (5,6) because they do not apply step (S3) before solving; a skeleton that fails (S3) is infeasible for its
  integer program too. The sets of skeletons that admit a feasible configuration are identical
  (`compare_milp_abs5.txt`).
* `audit/p2canon.cpp` searches standard networks (comparators (i,j) with i < j, the maximum delivered to channel
  N-1 and the second maximum to N-2). It keeps a cache of states without a completion and identifies states up
  to relabelling inputs and channels. It prunes with two lower bounds of Huffman type (`lb`, `lb2`); their
  justification is only sketched in the comments of the source, which is why the paper lists this search as a
  check without written proofs.
* In `audit/bftest/lemmas.log`, `lbViol`, `lb2Viol` and `symFail` count violations of the two bounds and of the
  symmetry reduction (all 0). `lb2badViol` counts violations by a variant of `lb2` that is known to be invalid
  (`lb2bad` in `bflemmas.cpp`); it is a negative control, and its hundreds of violations show that the test can
  detect an invalid bound.

Checks of the programs and logs of the search at N = 28 (`n28/`):

* `n28/run_checks.sh` reruns `abs9f` and `abs9g` on the 22 runs of `abs9` in `logs/search/` and writes the
  reports `compare_abs9f.out`, `compare_abs9g.out` and `check_splits.out`. With `SBORBIT=1`, `abs9g` prints each
  feasible assignment as the least member of its class under the group generated by the automorphisms g_v; the
  classes found with and without the symmetry test agree for each skeleton.
* `n28/compare_revisions.py` compares the earlier revisions of `abs9g` (`src/earlier/abs9g_r1.cpp` to
  `abs9g_r4.cpp`) with the final one (`src/abs9g.cpp`) on the same runs, and reruns the final one on 42 shares at
  N = 28, six from the logs of each script of `scripts/n28/`; report `n28/compare_revisions.out`.
* `n28/check_splits.py` runs `abs9f` and `abs9g` unsplit and split in every way used at N = 28, alone and nested,
  up to all seven splits nested for `abs9g`; report `n28/check_splits.out`.
* `scripts/check_n28.py` checks the logs of the search at N = 28 and compares them with the earlier run;
  report `n28/check_n28.out`.

