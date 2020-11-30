#!/bin/bash

mv ../src/pwhg_main .
mv ../src/powheg.input-save .
mv ../src/*.dat .
mv ../src/*.top .

cat powheg.input-save > powheg.input
echo "parallelstage 4" >> powheg.input
echo `date` "Powheg start" > run-st4-$GC_JOB_ID.log
echo $GC_JOB_ID | ./pwhg_main >> run-st4-$GC_JOB_ID.log 2>&1 &
wait
echo `date` "Powheg end" >> run-st4-$GC_JOB_ID.log 

mkdir tmp
printf -v id "%04d" $GC_JOB_ID

mv pwgevents-$id.lhe tmp/
mv pwgcounters-st4-$id.dat tmp/

rm *.top *.dat
mv tmp/* .
