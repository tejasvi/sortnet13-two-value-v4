#!/bin/bash
# Build the 33 certificate modules in batches, to bound memory (about 2.5 GB per module being
# elaborated, about 1 GB per module being compiled). Usage: scripts/build_s11_data.sh [BATCH=8]
set -euo pipefail
cd "$(dirname "$0")/.."
B=${1:-8}
N=$(ls S11Data/Chunk*.lean | wc -l)
for ((a = 0; a < N; a += B)); do
  mods=()
  for ((k = a; k < a + B && k < N; k++)); do mods+=("$(printf 'S11Data.Chunk%02d:dynlib' "$k")"); done
  echo "building ${mods[*]}"
  lake build "${mods[@]}"
done
lake build S11Data:shared
