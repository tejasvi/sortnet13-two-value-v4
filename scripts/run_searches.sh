#!/bin/bash
# Re-runs every computation of the paper (searches, F(N) and the upper-bound networks).
# Writes logs/search/<program>_N<N>_L<L>.log, logs/F.txt and logs/upper.txt.
# Each search log ends with the wall-clock time ("WALL ... s") and the exit status ("EXIT ...").
set -u
cd "$(dirname "$0")/.."
mkdir -p build logs/search
for p in abs5 abs9; do g++ -O2 -std=c++17 -o build/$p src/$p.cpp || exit 1; done

run() { # program N L
  local log=logs/search/$1_N$2_L$3.log
  { /usr/bin/time -f "WALL %e s" build/$1 $2 $3; echo "EXIT $?"; } > "$log" 2>&1
}

# Lower bounds: L = ceil(log2 F(N)) - 1 for N = 3..13 (abs5 and abs9), N = 17 (abs5 and abs9), N = 21 (abs9).
for t in "3 2" "4 3" "5 5" "6 5" "7 6" "8 6" "9 7" "10 7" "11 7" "12 8" "13 8" "17 9"; do
  run abs5 $t; run abs9 $t
done
run abs9 21 10
# Feasible levels L = ceil(log2 F(N)): every feasible configuration is rebuilt as a network and simulated.
for t in "3 3" "4 4" "5 6" "6 6" "7 7" "8 7" "11 8"; do run abs5 $t; run abs9 $t; done
run abs9 9 8
run abs9 10 8

# Van Voorhis's function and the upper-bound networks (Proposition 2.5), simulated on all runs.
python3 -I src/vvF.py > logs/F.txt
for n in $(seq 2 32); do python3 -I src/vv_construct.py $n; done > logs/upper.txt
