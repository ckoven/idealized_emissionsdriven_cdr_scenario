#! /bin/bash


rm /glade/scratch/charlie/archive/cesm_edriven_idealizedcdr_feb2022_v3/ocn/hist/cesm_edriven_idealizedcdr_feb2022_v3.pop.sofar.nc
rm /glade/scratch/charlie/archive/cesm_edriven_idealizedcdr_feb2022_v3/lnd/hist/cesm_edriven_idealizedcdr_feb2022_v3.clm2.sofar.nc
rm /glade/scratch/charlie/archive/cesm_edriven_idealizedcdr_feb2022_v3/atm/hist/cesm_edriven_idealizedcdr_feb2022_v3.cam.sofar.nc

cd /glade/scratch/charlie/archive/cesm_edriven_idealizedcdr_feb2022_v3/lnd/hist
ncrcat -cv TLAI,EFLX_LH_TOT,QVEGT,QVEGE,QSOIL,GPP,NPP,HR,CWDC,TOTSOMC_1m,TOTSOMC,TOTVEGC,TOTLITC,COL_FIRE_CLOSS,ALTMAX,NBP,NEE,PCO2,PBOT,TSA,FAREA_BURNED cesm_edriven_idealizedcdr_feb2022_v3.clm2.h0.0*.nc cesm_edriven_idealizedcdr_feb2022_v3.clm2.sofar.nc &

cd /glade/scratch/charlie/archive/cesm_edriven_idealizedcdr_feb2022_v3/atm/hist
ncrcat -cv PRECC,PRECL,TREFHT,CO2,PS,SFCO2,SFCO2_FFF,SFCO2_LND,SFCO2_OCN,TMCO2,TMCO2_FFF,TMCO2_LND,TMCO2_OCN cesm_edriven_idealizedcdr_feb2022_v3.cam.h0.0*.nc cesm_edriven_idealizedcdr_feb2022_v3.cam.sofar.nc &

cd /glade/scratch/charlie/archive/cesm_edriven_idealizedcdr_feb2022_v3/ocn/hist
ncrcat -cv FG_CO2,SSH,MOC cesm_edriven_idealizedcdr_feb2022_v3.pop.h.0*.nc cesm_edriven_idealizedcdr_feb2022_v3.pop.sofar.nc &
