#!/bin/bash
# Compares, for each (N, L) in runs/, the configurations that abs5 (runs/abs5cfg_N_L.txt, written by
# abs5_percfg) and the integer programs of milpcheck.py (runs/milpcfg_N_L.txt) find feasible.
cd "$(dirname "$0")/runs"
for f in abs5cfg_*.txt; do
  k=${f#abs5cfg_}; k=${k%.txt}; m=milpcfg_$k.txt
  a=$(grep -c ' feasible' $f); b=$(grep -c ' feasible' $m); na=$(grep -c '^CFG' $f); nb=$(grep -c '^CFG' $m)
  if diff <(grep ' feasible' $f | awk '{print $2}' | sort) <(grep ' feasible' $m | awk '{print $2}' | sort) > /dev/null
  then s=IDENTICAL; else s=DIFFERENT; fi
  echo "N,L=$k abs5: $na configs, $a feasible | MILP: $nb configs, $b feasible | feasible sets $s"
done
for f in milp_nodedup_*.txt; do tail -1 $f; done
