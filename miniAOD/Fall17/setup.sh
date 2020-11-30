#!/bin/bash

hmass=$1
gridpack="CMSSW_9_3_6/src/bbh__powheg_m${hmass}.tar.gz"

pwd=`pwd`
mkdir "m${hmass}"
workdir="$pwd/m${hmass}"

echo "Reminder: Copy gridpack tarball bbh_powheg_m${hmass}.tar.gz to CMSSW_9_3_6/src/ !"

cp template/*.py $workdir
cp template/*.conf $workdir
cd $workdir

sed -i "s/XHMASSX/${hmass}/g" grid_control_bbH_GENSIM.conf
sed -i "s/XHMASSX/${hmass}/g" gensim.py

sed -i "s/XHMASSX/${hmass}/g" grid_control_bbH_miniAOD.conf
sed -i "s/XHMASSX/${hmass}/g" makeAOD_step2.py
sed -i "s/XHMASSX/${hmass}/g" makeMiniAOD.py

cd $pwd