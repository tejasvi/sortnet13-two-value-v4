#!/bin/bash
# Simulates every witness network found by bf2: those of out/bf2_feas_*.txt (N = 8..12) and those printed in
# out/table_cleanroom.txt by rerun_table.sh (bf2 -k at L = P(2,N), N = 3..7). Writes out/check_witnesses.txt.
cd "$(dirname "$0")"
T=$(mktemp -d)
awk -v d="$T" '/^N=[0-9]+ L=[0-9]+ kraft=1 .* : FEASIBLE/ {f=sprintf("%s/w_%d.txt", d, ++k); print > f; getline; print > f; close(f)}' out/table_cleanroom.txt
python3 -B check_witness.py out/bf2_feas_*.txt "$T"/w_*.txt | sed "s|$T/||" > out/check_witnesses.txt
rm -rf "$T"
cat out/check_witnesses.txt
