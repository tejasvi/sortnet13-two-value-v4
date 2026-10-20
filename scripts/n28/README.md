# Scripts of the search at N = 28

These are the scripts that ran the search at N = 28, L = 11 on the compute servers, as they were run. Each server
had a working directory, `__WORKDIR__` in the scripts, with the binaries and a list of tasks, one task per line; the
scripts skip a task whose log already ends with `EXIT 0`, so they could be restarted. `__MAXP__` was the number of
processes per server (380 on servers with 384 hardware threads) and `__LIST__` the list of tasks of the server. Some servers ran the scripts
under a job queue and others directly; the binaries there were built from the same sources (statically linked).

| script | logs | binary | source |
|---|---|---|---|
| `shards.sh` | `pb_<s>.log` in `logs/n28/shards/` | `abs9f4` | `src/abs9f.cpp` |
| `split102.sh` | `f_<idx>_<i>.log` in `logs/n28/split102/` | `abs9f4` | `src/abs9f.cpp` |
| `sym17.sh` | `y_*.log` in `logs/n28/sym17/` | `abs9g` | `src/earlier/abs9g_r1.cpp` |
| `sym17_nested.sh` | `z_*.log` (8 nested shares at depth 10) | `abs9g` | `src/earlier/abs9g_r1.cpp` |
| `sym17_nested_r2.sh` | `w_*.log` (8 nested shares at depth 10) | `abs9g2` | `src/earlier/abs9g_r2.cpp` |
| `sym17_nested64_r2.sh` | `v_*.log` (64 nested shares at depth 12) | `abs9g2` | `src/earlier/abs9g_r2.cpp` |
| `sym17_nested_r3.sh` | `t_*.log` (4 shares at depth 14, or 32 at depth 16, of a share of `v_*`) | `abs9g3` | `src/earlier/abs9g_r3.cpp` |
| `sym17_nested_r4.sh` | `q_*.log` (16 shares at depth 18 of a share of `t_*` with 32 shares) | `abs9g4` | `src/earlier/abs9g_r4.cpp` |
| `sym17_nested_r5.sh` | `p_*.log` (8 shares at depth 20, 64 at depth 22 or 512 at depth 24 of a share of `q_*`) | `abs9g5` | `src/abs9g.cpp` |

`src/abs9g.cpp` is revision 5 of `abs9g`. Revision 2 computes the test (P3) and the symmetry test faster than
revision 1 and prints the same lines; revisions 3, 4 and 5 add a third, fourth and fifth level of splitting of the
depth-first search (`DFSSPLIT3` to `DFSSPLIT5`) and otherwise print the same lines as revision 2. `verification/n28/compare_revisions.py` checks
this.

A share was sometimes run more than once: whole and also split into nested shares, or by both revisions of
`abs9g`. A process whose share had been completed in another way was stopped, and the logs of stopped processes,
which contain no result line, are not included in `logs/n28/`. All complete logs are included. Where a share was
completed whole and also through its nested shares, `scripts/check_n28.py` uses the whole one; where the same share
was completed twice, it checks that the two result lines are equal.
