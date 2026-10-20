#!/bin/bash
# usage: cmpcfg.sh N L  -> compares feasible config sets of abs5 vs MILP
N=$1; L=$2
export OMP_NUM_THREADS=1 OPENBLAS_NUM_THREADS=1
nice -n 10 ./abs5_percfg $N $L 2>/dev/null | grep '^CFG' | sort > runs/abs5cfg_${N}_${L}.txt
nice -n 10 python3 milpcheck.py $N $L > runs/milp_${N}_${L}.txt
grep '^CFG' runs/milp_${N}_${L}.txt | sort > runs/milpcfg_${N}_${L}.txt
A=$(grep -c ' feasible' runs/abs5cfg_${N}_${L}.txt); B=$(grep -c ' feasible' runs/milpcfg_${N}_${L}.txt)
echo "N=$N L=$L abs5 feasible cfgs=$A  milp feasible cfgs=$B  milp-other=$(grep -c OTHER runs/milp_${N}_${L}.txt)"
diff <(grep ' feasible' runs/abs5cfg_${N}_${L}.txt | awk '{print $2}') <(grep ' feasible' runs/milpcfg_${N}_${L}.txt | awk '{print $2}') && echo "  feasible sets IDENTICAL"
