#!/bin/bash

mv ../src/pwhg_main .
mv ../src/powheg.input-save .
mv ../src/*.dat .
mv ../src/*.top .

cat powheg.input-save > powheg.input
echo "parallelstage 3" >> powheg.input
echo `date` "Powheg start" > run-st3-$GC_JOB_ID.log
echo $GC_JOB_ID | ./pwhg_main >> run-st3-$GC_JOB_ID.log 2>&1 &
wait
echo `date` "Powheg end" >> run-st3-$GC_JOB_ID.log 

mkdir tmp
printf -v id "%04d" $GC_JOB_ID

mv pwgborngrid.top tmp/
mv pwghistnorms.top tmp/
mv pwg-$id-btlgrid.top tmp/
mv pwg-$id-rmngrid.top tmp/
mv pwg-$id-stat.dat tmp/
mv pwgcounters-st3-$id.dat tmp/
mv pwggrid-$id.dat tmp/
mv pwg-st3-$id-stat.dat tmp/
mv pwgubound-$id.dat tmp/

rm *.top *.dat
mv tmp/* .
