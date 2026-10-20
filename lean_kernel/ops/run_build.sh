#!/bin/bash
# Full kernel build with timings and a memory monitor. usage: ops/run_build.sh JOBS
J=${1:-120}
# lake from the PATH (elan), or from the toolchain directory in LEAN_BIN
if [ -n "${LEAN_BIN:-}" ]; then export PATH="$LEAN_BIN:$PATH"; fi
cd "$(dirname "$0")/.."
mkdir -p logs
ulimit -n 65536; ulimit -s unlimited
rm -f logs/memmon.json.stop
{ lean --version; lake --version; echo "$(uname -s) $(uname -r | sed 's/[^0-9.].*//') $(uname -m)"; nproc; free -g | head -2; } > logs/toolchain.txt 2>&1
find S13Comp.lean S13 S13Kernel data -type f | sort | xargs sha256sum > logs/sources.sha256
python3 ops/memmon.py logs/memmon.json &
date -u +%FT%TZ > logs/build.start
LEAN_NUM_THREADS=$J /usr/bin/time -v lake build S13Kernel.Main > logs/build.log 2> logs/build.time
echo "exit=$?" >> logs/build.log
date -u +%FT%TZ > logs/build.end
lake env lean ops/Axioms.lean > logs/axioms.txt 2>&1
echo "axioms_exit=$?" >> logs/axioms.txt
touch logs/memmon.json.stop
