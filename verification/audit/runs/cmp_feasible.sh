#!/bin/bash
cd "$(dirname "$0")/.." || exit 1
for a in "7 7" "8 7" "11 8"; do ./cmpcfg.sh $a; done > runs/cmp_feasible.log 2>&1
