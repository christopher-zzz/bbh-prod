# bbh-prod

## Instructions to produce LHE files
1. `cd lhe`
2. In template dir modify paths in scripts, the lines which need to be changed start with `#PATH#`
3. Run `./setup.sh <higgs mass> <higgs width>` and go to the newly created directory
4. Submit jobs with config for stage1-1. After completion, copy the produced `*.dat` files from storage to`CMSSW_8_0_22/src/`.
5. Submit jobs with config for stage1-2. You can now check the prodcued .top files of stage1-iteration1 in the storage by using a .top -> .ps converter. If the grids look fine (=smooth from x=0 to x=1), proceed to point 7.
6. Repeat step 5 for as many iterations as needed to produce good grids. If this is not possible in 5 iterations, increase `ncalls1` in `CMSSW_8_0_22/src/powheg.input-save` or reduce the higgs width. The top files from any iteration can only be viewed after the next iterations has completed: after running 1-6, you can look at the top files from 1-5. Don't forget to copy the produced `*.dat` files to `CMSSW_8_0_22/src/` after each iteration.
7. Run stages 2, 3. After each stage copy the the produced `*.dat` files to `CMSSW_8_0_22/src/`.
8. Run stage 4, which produces the LHE files containing event information.

## Instructions to produce unofficial gridpacks
1. `gridpacks`
2. Follow instructions to produce LHE files up to stage3, no actual LHE files need to be produced
3. Execute `setup.sh <run> <xgridit>`, where `<run>` is the selected name for the run and `<xgridit>` is the iteration with the smoothest grids in stage1.
4. The produced gridpack is located in `./<run>/bbh_powheg_<run>.tar.gz`

## Instructions for miniAOD:
1. Produce a gridpack of the desired masspoint (see above)
2. `cd miniAOD/Fall17`, scripts need to be modified to work with other eras
3. Setup `CMSSW_9_3_6` and `CMSSW_9_4_7`
4. Copy the gridpack to `CMSSW_9_3_6/src/`
5. In the config scripts in the template directory, modify the lines starting with `#PATH#` according to your setup
6. Run `./setup.sh <mass>` and go to nely created directory of the run
7. `cmsenv` in `CMSSW_9_3_6/src/` and submit jobs for GENSIM step.
8. `dataset_list_from_gc.py -o filelist_gensim.txt grid_control_bbH_GENSIM.conf`
9. `cmsenv` in `CMSSW_9_4_7/src/` and submit jobs for miniAOD step.
