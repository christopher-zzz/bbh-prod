#!/bin/bash

xgridit=$1

mv ../src/pwhg_main .
mv ../src/powheg.input-* .
mv ../src/*.dat .
mv ../src/*.top .

if [ $xgridit -eq 5 ]
then
	cat powheg.input-xgrid6 > powheg.input	
else
	cat powheg.input-save > powheg.input
fi

echo "parallelstage 1" >> powheg.input
echo "xgriditeration $xgridit" >> powheg.input
echo `date` "Powheg start" > run-st1-xg$xgridit-$GC_JOB_ID.log
echo $GC_JOB_ID | ./pwhg_main >> run-st1-xg$xgridit-$GC_JOB_ID.log 2>&1 &
wait

mkdir tmp
printf -v id "%04d" $GC_JOB_ID

mv pwg-$id-btlgrid.top tmp/
mv pwg-$id-rmngrid.top tmp/  
mv pwg-xg$xgridit-$id-btlgrid.top tmp/
mv pwg-xg$xgridit-$id-rmngrid.top tmp/
mv pwggridinfo-btl-xg$xgridit-${id}.dat tmp/
mv pwggridinfo-rmn-xg$xgridit-${id}.dat tmp/ 
mv pwgcounters-st1-${id}.dat tmp/

rm *.top *.dat
mv tmp/* .
