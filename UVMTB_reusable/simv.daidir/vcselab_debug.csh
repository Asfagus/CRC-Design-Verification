#!/bin/csh -f

cd /home/014545440/proj_upload/CRC-Design-Verification/UVMTB_reusable

#This ENV is used to avoid overriding current script in next vcselab run 
setenv SNPS_VCSELAB_SCRIPT_NO_OVERRIDE  1

/apps/synopsys/vcs/R-2020.12/linux/bin/vcselab $* \
    -o \
    simv \
    -nobanner \

cd -

