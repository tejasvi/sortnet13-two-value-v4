#!/bin/bash
# abs9g nested DFS split for the 17 hardest N=28 shapes: each line "idx i P j Q m R D m2 R2 D2" of __LIST__ runs
# part i of P (level 10), sub-part j of Q (level 16), DFS share m of R at depth D, and nested DFS share m2 of R2 at
# depth D2. Logs z_<idx>_<i>_<j>_<m>of<R>d<D>_<m2>of<R2>d<D2>.log ending in "EXIT <status>". At most __MAXP__
# abs9g processes on this server. Resumable.
cd __WORKDIR__ || exit 1
MAXP=__MAXP__; LIST=__LIST__
[ -x abs9g ] || g++ -O2 -std=c++17 -o abs9g abs9g.cpp || exit 1
while read idx i P j Q m R D m2 R2 D2; do
  f=z_${idx}_${i}_${j}_${m}of${R}d${D}_${m2}of${R2}d${D2}.log
  if [ -f $f ] && [ "$(tail -n 1 $f)" = "EXIT 0" ]; then continue; fi
  while [ "$(pgrep -c -x abs9g)" -ge $MAXP ]; do sleep 2; done
  ( CFGSPLIT=$i/$P SPLITLEVEL=10 CFGSPLIT2=$j/$Q SPLITLEVEL2=16 DFSSPLIT=$m/$R DFSSPLITDEPTH=$D DFSSPLIT2=$m2/$R2 DFSSPLITDEPTH2=$D2 ./abs9g 28 11 $idx 62641 > $f 2>&1; echo "EXIT $?" >> $f ) &
  sleep 0.02
done < $LIST
wait
while read idx i P j Q m R D m2 R2 D2; do [ "$(tail -n 1 z_${idx}_${i}_${j}_${m}of${R}d${D}_${m2}of${R2}d${D2}.log 2>/dev/null)" = "EXIT 0" ] || exit 1; done < $LIST
exit 0
