#!/bin/bash
#------------------------------------
# RUN SPECIFIC SETUP - USER TO MODIFY
#------------------------------------
# Set a descriptive name for the case to be run
export CASENAME=cesm_edriven_idealizedcdr_feb2022_v3

# Set debugging option on or off
export DEBUGGING=FALSE

# Set the desired compset - use query_config and/or query_testlist for compset names
#export COMPSET=1850_CAM60_CLM50%BGC-CROP-CMIP6DECK_CICE%CMIP6_POP2%ECO%ABIO-DIC_MOSART_CISM2%NOEVOLVE_WW3_BGC%BPRP
export COMPSET=B1850_BPRP
#export COMPSET=B1850_BPRPcmip6
#export COMPSET=BHIST_BPRPcmip6

# Set the resolution
#export RESOLUTION=a%0.9x1.25_l%0.9x1.25_oi%gx1v7_r%r05_g%gland4_w%ww3a_m%gx1v7
export RESOLUTION=f09_g17


#------------------------------------------------------
# USER AND MACHINE SPECIFIC SETUP - CHANGE AS NECESSARY
#------------------------------------------------------
export PROJECT=UWAS0044
export MACH=cheyenne
#export COMPILER=intel
export CASEDIR=/glade/scratch/charlie/
export MODELDIR=/glade/u/home/charlie/my_cesm_sandbox

cd ${MODELDIR}

git checkout release-cesm2.1.3

./manage_externals/checkout_externals

cd ${MODELDIR}/cime/scripts

# Setup build, run and output directory name

#----------------
# CREATE THE CASE
#----------------
./create_newcase --case=${CASENAME} --project=${PROJECT} --res=${RESOLUTION} --compset=${COMPSET} --mach=${MACH} #--compiler=${COMPILER} --run-unsupported


cd $CASENAME


#./xmlchange RUN_STARTDATE=1850-01-01

./xmlchange RUN_REFCASE=b.e21.B1850.f09_g17.CMIP6-esm-piControl.001
./xmlchange RUN_REFDATE=0151-01-01

./xmlchange STOP_OPTION=nyears
./xmlchange RESUBMIT=3
./xmlchange STOP_N=3
./xmlchange JOB_QUEUE=economy

cat >> user_nl_cam <<EOF #-------------------------
co2_readflux_aircraft= .false.
co2_readflux_fuel= .true.
co2flux_fuel_file= '/glade/scratch/charlie/emissions_idealized_edrivencdr_000101-031012_fv_0.9x1.25_cdk_20220218.nc'
EOF

cat >> user_nl_clm <<EOF
fsurdat = '/glade/p/cesmdata/cseg/inputdata/lnd/clm2/surfdata_map/release-clm5.0.18/surfdata_0.9x1.25_hist_78pfts_CMIP6_simyr1850_c190214.nc'
EOF



# SETUP AND BUILD THE CASE
#-------------------------
./case.setup
qcmd -- ./case.build


./case.submit
