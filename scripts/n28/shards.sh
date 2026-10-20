#!/bin/bash
# Phase B: abs9f on all N=28 shapes except the 119 of hard119.txt, in 4096 shards (shard s = shapes with index
# congruent to s mod 4096). Each line of __LIST__ is one shard. Logs pb_<s>.log ending in "EXIT <status>".
# At most __MAXP__ abs9f processes in total on this server. Resumable.
cd __WORKDIR__ || exit 1
MAXP=__MAXP__; LIST=__LIST__
[ -x abs9f4 ] || g++ -O2 -std=c++17 -o abs9f4 abs9f4.cpp || exit 1
while read s; do
  f=pb_${s}.log
  if [ -f $f ] && [ "$(tail -n 1 $f)" = "EXIT 0" ]; then continue; fi
  while [ "$(( $(pgrep -c -x abs9f) + $(pgrep -c -x abs9f2) + $(pgrep -c -x abs9f3) + $(pgrep -c -x abs9f4) ))" -ge $MAXP ]; do sleep 2; done
  ( SKIPFILE=hard119.txt ./abs9f4 28 11 $s 4096 > $f 2>&1; echo "EXIT $?" >> $f ) &
  sleep 0.02
done < $LIST
wait
while read s; do [ "$(tail -n 1 pb_${s}.log 2>/dev/null)" = "EXIT 0" ] || exit 1; done < $LIST
exit 0
