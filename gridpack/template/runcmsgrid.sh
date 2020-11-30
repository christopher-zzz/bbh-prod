#!/bin/bash

nevt=${1}
rnum=${2}	# SEED

scram_arch_version=slc6_amd64_gcc530
cmssw_version=CMSSW_8_0_22

LHEWORKDIR=`pwd`

export SCRAM_ARCH=$scram_arch_version
source /cvmfs/cms.cern.ch/cmsset_default.sh
if [ -r ${cmssw_version}/src ] ; then
	echo release ${cmssw_version} already exists
else
	scram p CMSSW ${cmssw_version}
fi
cd ${cmssw_version}/src
eval `scram runtime -sh`
cd -

cat powheg.input-save > powheg.input
sed -i "s/NEVENTS/${nevt}/g" powheg.input
sed -i "s/SEED/${rnum}/g" powheg.input
echo "parallelstage 4" >> powheg.input
echo $rnum > pwgseeds.dat

if [ -f pwgevents-0001.lhe ] ; then
	mv pwgevents-0001.lhe pwgevents-0001.lhe_old
fi

echo "Start generating events on " `date`
echo 1 | ./pwhg_main > lhe_generation.log 2>&1 &
wait
cat pwgevents-0001.lhe | grep -v "Random number generator exit values" > cmsgrid_final.lhe	
xmllint --noout cmsgrid_final.lhe > /dev/null 2>&1; test $? -eq 0 || fail_exit "xmllint integrity check failed on pwgevents.lhe"

echo "End of job on " `date`
