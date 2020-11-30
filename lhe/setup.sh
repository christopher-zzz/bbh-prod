#!/bin/bash

export VO_CMS_SW_DIR=/cvmfs/cms.cern.ch
source $VO_CMS_SW_DIR/cmsset_default.sh

mass=$1
width=$2
hdamp=`awk "BEGIN {print ($mass+8.36)/4}"`

workdir=`pwd`
massdir=$workdir/m${mass}
CMSSWdir=$massdir/CMSSW_8_0_22/src
template=$workdir/template

mkdir $massdir
cd $massdir

scramv1 project CMSSW CMSSW_8_0_22
cd $CMSSWdir ; eval `scramv1 runtime -sh` ; cd $massdir

echo "Copying files:"
cp -v $template/*.conf $massdir
cp -v $template/pwgseeds.dat $CMSSWdir
cp -v $template/*.sh $CMSSWdir
cp -v $template/pwhg_main $CMSSWdir
cp -v $template/powheg.input-* $CMSSWdir

sed -i "s/XHMASSX/${mass}/g" *.conf
sed -i "s/XHMASSX/${mass}/g" $CMSSWdir/powheg.input-*
sed -i "s/XHWIDTHX/${width}/g" $CMSSWdir/powheg.input-*
sed -i "s/XHDAMPX/${hdamp}/g" $CMSSWdir/powheg.input-*

cd $workdir 
