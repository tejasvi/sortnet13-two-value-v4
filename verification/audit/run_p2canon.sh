#!/bin/bash
# Model-free check: exhaustive search over standard-form networks (p2canon.cpp) at N = 12, 13 and L = 8, 9.
# Arguments of p2canon: N L D T GB (BFS frontier depth D, T threads, GB of failure cache).
cd "$(dirname "$0")"
g++ -O2 -std=c++17 -pthread -o p2canon p2canon.cpp || exit 1
for t in "12 8" "13 8" "12 9" "13 9"; do
  set -- $t
  ./p2canon $1 $2 6 24 8 > runs/p2canon_rerun_$1_$2.txt 2> runs/p2canon_rerun_$1_$2.err
done
