#!/bin/bash
# Tests the two lower bounds (lb, lb2) and the symmetry reduction used by p2canon on every prefix of
# top-two networks: the networks of pool.txt plus 2000 random minimal ones per N (fixed seed).
# A violation would mean lb or lb2 exceeds p2 of a completion, or the symmetry map changes feasibility.
cd "$(dirname "$0")"
g++ -O2 -std=c++17 -o bflemmas bflemmas.cpp || exit 1
for N in 4 5 6 7 8 9 10 11 12 13; do ./bflemmas $N 200 2000 < pool.txt; done
