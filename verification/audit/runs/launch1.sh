#!/bin/bash
cd "$(dirname "$0")/.." || exit 1
A=./audit
# random minimal / sorter-derived
for N in 5 6 7 8 9; do
  nice -n 10 $A randmin $N 20000 $((100+N)) > runs/randmin_$N.txt 2>/dev/null &
  nice -n 10 $A sortmin $N 5000 $((200+N)) > runs/sortmin_$N.txt 2>/dev/null &
done
# SA near optimum: P(5..11)=6,6,7,7,8,8,8
declare -A P=([5]=6 [6]=6 [7]=7 [8]=7 [9]=8 [10]=8 [11]=8)
for N in 5 6 7 8 9 10 11; do
  PERRUN=10 nice -n 10 $A sa $N 3000 $((300+N)) ${P[$N]} 2000000 > runs/sa_P_$N.txt 2>/dev/null &
  PERRUN=10 nice -n 10 $A sa $N 1000 $((400+N)) $((P[$N]+1)) 2000000 > runs/sa_P1_$N.txt 2>/dev/null &
done
wait
