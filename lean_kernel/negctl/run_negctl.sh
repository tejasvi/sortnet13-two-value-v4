#!/bin/bash
# Run every negative control; each must FAIL. usage (from the project root): negctl/run_negctl.sh
python3 negctl/make_negctl.py
# lake from the PATH (elan), or from the toolchain directory in LEAN_BIN
if [ -n "${LEAN_BIN:-}" ]; then export PATH="$LEAN_BIN:$PATH"; fi
for f in negctl/Neg*.lean; do
  ( out=$(lake env lean "$f" 2>&1); rc=$?
    if [ $rc -ne 0 ]; then echo "$(basename $f .lean): REJECTED (exit $rc): $(echo "$out" | grep -m1 -i error | cut -c1-160)"
    else echo "$(basename $f .lean): ACCEPTED (unexpected)"; fi ) &
done
wait
