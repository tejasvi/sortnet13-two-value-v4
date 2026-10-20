#!/bin/bash
# abs9g runs for the 17 hardest N=28 shapes: each line "idx i P j Q m R D" of __LIST__ runs part i of P (CFGSPLIT,
# level 10), sub-part j of Q (CFGSPLIT2, level 16; Q=1: none) and DFS part m of R at depth D (DFSSPLIT; R=1: none)
# of the shape with index idx. Logs y_<idx>_<i>_<j>_<m>of<R>d<D>.log ending in "EXIT <status>"; at most __MAXP__
# search processes in total on this server. Resumable.
cd __WORKDIR__ || exit 1
MAXP=__MAXP__; LIST=__LIST__
[ -x abs9g ] || g++ -O2 -std=c++17 -o abs9g abs9g.cpp || exit 1
while read idx i P j Q m R D; do
  f=y_${idx}_${i}_${j}_${m}of${R}d${D}.log
  if [ -f $f ] && [ "$(tail -n 1 $f)" = "EXIT 0" ]; then continue; fi
  while [ "$(( $(pgrep -c -x abs9f) + $(pgrep -c -x abs9f2) + $(pgrep -c -x abs9f3) + $(pgrep -c -x abs9f4) + $(pgrep -c -x abs9g) ))" -ge $MAXP ]; do sleep 2; done
  E="CFGSPLIT=$i/$P SPLITLEVEL=10"
  [ "$Q" != 1 ] && E="$E CFGSPLIT2=$j/$Q SPLITLEVEL2=16"
  [ "$R" != 1 ] && E="$E DFSSPLIT=$m/$R DFSSPLITDEPTH=$D"
  ( env $E ./abs9g 28 11 $idx 62641 > $f 2>&1; echo "EXIT $?" >> $f ) &
  sleep 0.02
done < $LIST
wait
while read idx i P j Q m R D; do [ "$(tail -n 1 y_${idx}_${i}_${j}_${m}of${R}d${D}.log 2>/dev/null)" = "EXIT 0" ] || exit 1; done < $LIST
exit 0
