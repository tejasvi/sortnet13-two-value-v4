#!/bin/bash
# Re-runs the clean-room lower-bound checks of METHOD.md, Section 0, for N = 3..13:
# Method A (bf2 -k), Method B (gm.py), Method C (gm_pure2.py) at L = P-1 (infeasible) and,
# for B and C, at L = P (feasible); bf2 -k at L = P for N <= 7 (larger N: out/bf2_feas_*.txt).
# P(2,N) = 3 4 6 6 7 7 8 8 8 9 9 for N = 3..13. Usage: ./rerun_table.sh > out/table_cleanroom.txt 2> out/table_cleanroom.err
cd "$(dirname "$0")"
# stdout: results; progress messages of bf2 go to stderr
g++ -O2 -std=c++17 -o bf2 bf2.cpp || exit 1
P=(0 0 0 3 4 6 6 7 7 8 8 8 9 9)
for N in $(seq 3 13); do
  p=${P[$N]}
  ./bf2 $N $((p-1)) -k
  python3 -B gm.py $N $((p-1))
  python3 -B gm.py $N $p
  python3 -B gm_pure2.py $N $((p-1))
  python3 -B gm_pure2.py $N $p
  if [ $N -le 7 ]; then ./bf2 $N $p -k; fi
done
