#!/bin/bash

## Check if the arguments are valid
if [ "$#" -lt "2" ] || [ "$#" -gt "3" ]
then
    echo
    echo Incorrect number of arguments
    echo
    echo REQUIRED PARAMETER 1: Slot number of the SSB
    echo REQUIRED PARAMETER 2: FPGA number of the EXTF
    echo OPTIONAL PARAMETER 3: To disable the loading of Constants use the fast option 
    echo "EXAMPLE:     ./configure_extf.sh N M         ## Configure and Load Slot N, FPGA M" 
    echo "EXAMPLE:     ./configure_extf.sh N M fast    ## Configure Slot N, FPGA M"
    echo
    exit 1
fi
if [ "$1" -lt "0" ] || [ "$1" -gt "31" ]
then
    echo
    echo Slot number must be between 0-31
    echo
    echo REQUIRED PARAMETER 1: Slot number of the SSB
    echo REQUIRED PARAMETER 2: FPGA number of the EXTF
    echo OPTIONAL PARAMETER 3: To disable the loading of Constants use the fast option 
    echo "EXAMPLE:     ./configure_extf.sh N M         ## Configure and Load Slot N, FPGA M" 
    echo "EXAMPLE:     ./configure_extf.sh N M fast    ## Configure Slot N, FPGA M"
    echo
    exit 1
fi
if [ "$2" -lt "0" ] || [ "$2" -gt "3" ]
then
    echo
    echo FPGA number must be between 0-3
    echo
    echo REQUIRED PARAMETER 1: Slot number of the SSB
    echo REQUIRED PARAMETER 2: FPGA number of the EXTF
    echo OPTIONAL PARAMETER 3: To disable the loading of Constants use the fast option 
    echo "EXAMPLE:     ./configure_extf.sh N M         ## Configure and Load Slot N, FPGA M" 
    echo "EXAMPLE:     ./configure_extf.sh N M fast    ## Configure Slot N, FPGA M"
    echo
    exit 1
fi
if [ "$#" -eq "3" ] && [ "$3" != "fast" ]
then
    echo
    echo Unrecognized parameter $3
    echo
    echo REQUIRED PARAMETER 1: Slot number of the SSB
    echo REQUIRED PARAMETER 2: FPGA number of the EXTF
    echo OPTIONAL PARAMETER 3: To disable the loading of Constants use the fast option 
    echo "EXAMPLE:     ./configure_extf.sh N M         ## Configure and Load Slot N, FPGA M" 
    echo "EXAMPLE:     ./configure_extf.sh N M fast    ## Configure Slot N, FPGA M"
    echo
    exit 1
fi



## Need to get the hex code for the slot number
case $1 in 
     0 ) hex_code=00;;    1 ) hex_code=08;;
     2 ) hex_code=10;;    3 ) hex_code=18;;
     4 ) hex_code=20;;    5 ) hex_code=28;;
     6 ) hex_code=30;;    7 ) hex_code=38;;
     8 ) hex_code=40;;    9 ) hex_code=48;;
    10 ) hex_code=50;;   11 ) hex_code=58;;
    12 ) hex_code=60;;   13 ) hex_code=68;;
    14 ) hex_code=70;;   15 ) hex_code=78;;
    16 ) hex_code=80;;   17 ) hex_code=88;;
    18 ) hex_code=90;;   19 ) hex_code=98;;
    20 ) hex_code=a0;;   21 ) hex_code=a8;;
    22 ) hex_code=b0;;   23 ) hex_code=b8;;
    24 ) hex_code=c0;;   25 ) hex_code=c8;;
    26 ) hex_code=d0;;   27 ) hex_code=d8;;
    28 ) hex_code=e0;;   29 ) hex_code=e8;;
    30 ) hex_code=f0;;   31 ) hex_code=f8;;
esac


echo
echo ----------------------------------------------------------------------------------------
echo Configuring EXTF $2 \in Slot $1 \($hex_code\) 					   
echo ----------------------------------------------------------------------------------------
echo


#############################################################################################
#############################################################################################
##                                                                                         ##
##                        General        EXTF        Settings                              ##
##                                                                                         ##
#############################################################################################
#############################################################################################



## Run Control Transitions
##-------------------------------------------------------------------------------------------
vme_poke 0x$hex_code\00$2\600            ## Configure
##vme_poke 0x$hex_code\00$2\604            ## Connect
##vme_poke 0x$hex_code\00$2\608            ## Start
##vme_poke 0x$hex_code\00$2\60C            ## Stop
##vme_poke 0x$hex_code\00$2\610            ## Disconnect
##vme_poke 0x$hex_code\00$2\614            ## Unconfigure




## Idle Words
##-------------------------------------------------------------------------------------------
if [ "$2" -eq "0" ] || [ "$2" -eq "1" ]      ## Check if Primary
then
    echo Configuring Primary Idle Words
    ##vme_poke 0x$hex_code\00$2\618 0x0            ## AUX/DF        0000bcc5 / c5c5c5bc
    vme_poke 0x$hex_code\00$2\618 0x1            ## Octopus/SSB   c9c9c9bc
else
    echo Configuring Secondary Idle Words
    ##vme_poke 0x$hex_code\00$2\618 0x0            ## AUX/DF        0000bcc5 / c5c5c5bc
    vme_poke 0x$hex_code\00$2\618 0x1            ## Octopus/SSB   c9c9c9bc
fi




## # of Input Streams
##-------------------------------------------------------------------------------------------
echo Configuring Number of Input Streams
##vme_poke 0x$hex_code\00$2\61C 0x0            ## 2 DF_ streams DF__A and DF__B
vme_poke 0x$hex_code\00$2\61C 0x1            ## 1 DF_ stream  DF__A Only
##vme_poke 0x$hex_code\00$2\62C 0x0            ## 2 AUX streams AUX_A and AUX_B
vme_poke 0x$hex_code\00$2\62C 0x1            ## 1 AUX stream  AUX_A Only




## Ignore Backpressure
##-------------------------------------------------------------------------------------------
echo Configuring Hit Warrior Backpressure Settings
##vme_poke 0x$hex_code\00$2\624 0x0            ## Respect BP from HitWarrior
vme_poke 0x$hex_code\00$2\624 0x1            ## Ignore  BP from HitWarrior
if [ "$2" -eq "0" ] || [ "$2" -eq "1" ]      ## Check if Primary
then
    echo Configuring Secondary Backpressure Settings
    ##vme_poke 0x$hex_code\00$2\628 0x0            ## Respect BP from Secondary
    vme_poke 0x$hex_code\00$2\628 0x1            ## Ignore  BP from Secondary
fi




## Select AUX Stream
##-------------------------------------------------------------------------------------------
if [ "$2" -eq "0" ] || [ "$2" -eq "1" ]      ## Check if Primary
then
    echo Selecting Primary AUX Stream
    vme_poke 0x$hex_code\00$2\620 0x0            ## Process AUX-A stream
    ##vme_poke 0x$hex_code\00$2\620 0x1            ## Process AUX-B stream    
else
    echo Selecting Secondary AUX Stream
    ##vme_poke 0x$hex_code\00$2\620 0x0            ## Process AUX-A stream
    vme_poke 0x$hex_code\00$2\620 0x1            ## Process AUX-B stream    
fi




echo
echo
#############################################################################################
#############################################################################################
##                                                                                         ##
##                                        Constants                                        ##
##                                                                                         ##
#############################################################################################
#############################################################################################
if [ "$#" -eq "2" ]                          ## Loading is Bypassed using the fast option
then                                         ## ./configure_extf.sh 6 2 fast 
echo ----------------------------------------------------------------------------------------
echo Loading Constants
echo ----------------------------------------------------------------------------------------
echo

# EXP_f=/afs/cern.ch/user/m/matkinso/public/FTK/TestVectors/EXPConstants_reg22.txt
# TF_f=/afs/cern.ch/user/m/matkinso/public/FTK/TestVectors/TFConstants_reg22.txt
EXP_f=/afs/cern.ch/work/v/vcavalie/public/constants/64tower_config/data_alignment/EXPConstants_reg22.txt
TF_f=/afs/cern.ch/work/v/vcavalie/public/constants/64tower_config/data_alignment/TFConstants_reg22.txt
# EXP_f=/afs/cern.ch/work/v/vcavalie/public/constants/EXPConstants_reg22.txt
# TF_f=/afs/cern.ch/work/v/vcavalie/public/constants/TFConstants_reg22.txt

ssb_const_load_from_txt_app --slot $1 --fpga $2 --exp $EXP_f --tkf $TF_f


echo
echo Done Loading Constants
fi

exit 0
