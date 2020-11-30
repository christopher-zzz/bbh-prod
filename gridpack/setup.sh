#!/bin/bash

run=$1
xgridit=$2

workdir=`pwd`
massdir=$workdir/${run}

mkdir -v $massdir
cp -v template/* $massdir
#PATH# cp -v /portal/ekpbms1/home/czimmer/POWHEG-batch/${run}/CMSSW_8_0_22/src/powheg.input-save $massdir

cd $massdir
sed -i "s/numevts/numevts NEVENTS !/g" powheg.input-save
#PATH# cp -v /storage/gridka-nrg/czimmer/powheg_grids/${run}/stage1-${xgridit}/*.dat .
#PATH# cp -v /storage/gridka-nrg/czimmer/powheg_grids/${run}/stage2/*.dat .
#PATH# cp -v /storage/gridka-nrg/czimmer/powheg_grids/${run}/stage3/*.dat .
rm pwgcounters*
rm pwg-st3-00[0-9][1-9]-stat.dat	# keep some info
rm pwg-????-stat.dat
tar czvf bbh_powheg_${run}.tar.gz *
cd $workdir

