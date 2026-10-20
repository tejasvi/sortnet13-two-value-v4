#!/bin/bash
# Re-runs the checks of the programs used at N = 28 (rows "abs9f against abs9", "abs9g against abs9f" and
# "split runs against unsplit runs" of Table 3). Writes the logs below verification/n28/ and the three reports
# compare_abs9f.out, compare_abs9g.out and check_splits.out. Takes about 15 minutes; the runs at N = 9, L = 8
# take most of it.
set -u
cd "$(dirname "$0")/../.."
mkdir -p build verification/n28/abs9f_vs_abs9 verification/n28/abs9g
for p in abs9f abs9g; do g++ -O2 -std=c++17 -o build/$p src/$p.cpp || exit 1; done
for f in logs/search/abs9_N*_L*.log; do
  b=$(basename "$f" .log); NL=${b#abs9_}; N=${NL%_L*}; N=${N#N}; L=${NL#*_L}
  build/abs9f $N $L > verification/n28/abs9f_vs_abs9/abs9f_N${N}_L${L}.log 2>&1 &
  SYMBREAK=0 build/abs9g $N $L > verification/n28/abs9g/s0_N${N}_L${L}.log 2>&1 &
  SYMBREAK=1 build/abs9g $N $L > verification/n28/abs9g/s1_N${N}_L${L}.log 2>&1 &
  wait
done
# feasible levels: every feasible assignment printed as the least member of its class (SBORBIT=1)
for t in "3 3" "4 4" "5 6" "6 6" "7 7" "8 7" "9 8" "10 8" "11 8"; do set -- $t
  SYMBREAK=0 SBORBIT=1 build/abs9g $1 $2 > verification/n28/abs9g/o0_N$1_L$2.log 2>&1 &
  SYMBREAK=1 SBORBIT=1 build/abs9g $1 $2 > verification/n28/abs9g/o1_N$1_L$2.log 2>&1 &
  wait
done
python3 -B verification/n28/compare_abs9f.py > verification/n28/compare_abs9f.out
python3 -B verification/n28/compare_abs9g.py > verification/n28/compare_abs9g.out
python3 -B verification/n28/check_splits.py build/abs9f build/abs9g > verification/n28/check_splits.out
tail -n 1 verification/n28/compare_abs9f.out verification/n28/compare_abs9g.out verification/n28/check_splits.out
