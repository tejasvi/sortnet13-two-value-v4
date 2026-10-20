#!/bin/bash
# Re-run with the final abs9f (binary abs9f4 = src/abs9f.cpp) of the 102 shapes split into 64 shares: each line
# "idx i" of __LIST__ runs CFGSPLIT=i/64 at level 10 of the shape with index idx. Logs f_<idx>_<i>.log ending in
# "EXIT <status>". At most __MAXP__ search processes in total on this server. Resumable.
cd __WORKDIR__ || exit 1
MAXP=__MAXP__; LIST=__LIST__
[ -x abs9f4 ] || g++ -O2 -std=c++17 -o abs9f4 abs9f4.cpp || exit 1
while read idx i; do
  f=f_${idx}_${i}.log
  if [ -f $f ] && [ "$(tail -n 1 $f)" = "EXIT 0" ]; then continue; fi
  while [ "$(( $(pgrep -c -x abs9f4) + $(pgrep -c -x abs9g) + $(pgrep -c -x abs9g2) ))" -ge $MAXP ]; do sleep 2; done
  ( CFGSPLIT=$i/64 SPLITLEVEL=10 ./abs9f4 28 11 $idx 62641 > $f 2>&1; echo "EXIT $?" >> $f ) &
  sleep 0.02
done < $LIST
wait
while read idx i; do [ "$(tail -n 1 f_${idx}_${i}.log 2>/dev/null)" = "EXIT 0" ] || exit 1; done < $LIST
exit 0
