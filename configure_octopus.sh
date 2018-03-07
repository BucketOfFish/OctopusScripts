#!/bin/bash

## Check if the arguments are valid
if [ "$#" -eq "0" ] || [ "$#" -gt "2" ]
then
    echo
    echo Incorrect number of arguments
    echo
    echo REQUIRED PARAMETER 1: Slot number of the Data Octopus
    echo OPTIONAL PARAMETER 2: To disable the loading of Test Vectors use the fast option 
    echo "EXAMPLE:     ./configure_octopus.sh N         ## Configure and Load Slot N" 
    echo "EXAMPLE:     ./configure_octopus.sh N fast    ## Configure Slot N"
    echo
    exit 1
fi
if [ "$1" -lt "0" ] || [ "$1" -gt "31" ]
then
    echo
    echo Slot number must be between 0-31
    echo
    echo REQUIRED PARAMETER 1: Slot number of the Data Octopus
    echo OPTIONAL PARAMETER 2: To disable the loading of Test Vectors use the fast option 
    echo "EXAMPLE:     ./configure_octopus.sh N         ## Configure and Load Slot N" 
    echo "EXAMPLE:     ./configure_octopus.sh N fast    ## Configure Slot N"
    echo
    exit 1
fi
if [ "$#" -eq "2" ] && [ "$2" != "fast" ]
then
    echo
    echo Unrecognized parameter $2
    echo
    echo REQUIRED PARAMETER 1: Slot number of the Data Octopus
    echo OPTIONAL PARAMETER 2: To disable the loading of Test Vectors use the fast option 
    echo "EXAMPLE:     ./configure_octopus.sh N         ## Configure and Load Slot N" 
    echo "EXAMPLE:     ./configure_octopus.sh N fast    ## Configure Slot N"
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
PUR='\033[0;35m'
NC='\033[0m'



#############################################################################################
#############################################################################################
echo											   ##
echo											   ##
echo											   ##
echo "     888        888            "							   ##
echo "     888        888            "							   ##
echo "     888        888            "							   ##
echo " .d88888 8888b. 888888 8888b.  "							   ##
echo "d88\" 888    \"88b888       \"88b "						   ##
echo "888  888.d888888888   .d888888 "							   ##
echo -e "Y88b 888888  888Y88b. 888  888 ${PUR}888 ${NC}"						   
echo -e " \"Y88888\"Y888888 \"Y888\"Y888888 ${PUR}888 ${NC}"						   
echo -e "${PUR}                               888                                   ${NC}" 		   
echo -e "${PUR}                .d88b.  .d8888b888888 .d88b. 88888b. 888  888.d8888b ${NC}" 		   
echo -e "${PUR}               d88\"\"88bd88P\"   888   d88\"\"88b888 \"88b888  88888K     ${NC}" 	   
echo -e "${PUR}               888  888888     888   888  888888  888888  888\"Y8888b.${NC}" 		   
echo -e "${PUR}               Y88..88PY88b.   Y88b. Y88..88P888 d88PY88b 888     X88${NC}" 		   
echo -e "${PUR}                \"Y88P\"  \"Y8888P \"Y888 \"Y88P\" 88888P\"  \"Y88888 88888P'${NC}" 	   
echo -e "${PUR}                                             888                     ${NC}" 		   
echo -e "${PUR}                                             888                     ${NC}" 		   
echo -e "${PUR}                                             888                     ${NC}" 		   
echo											   ##
echo											   ##
echo											   ##
echo -e "${PUR}¤ø,¸,ø¤°º¤ø,¸¸,ø¤º°\`°º¤ø,¸,ø¤°º¤ø,¸¸,ø¤º°\`°º¤ø,¸,ø¤°º¤ø,¸¸,ø¤º°\`°º¤ø,${NC}"
echo Configuring Octopus \in Slot $1 \($hex_code\)					   ##
echo -e "${PUR}¤ø,¸,ø¤°º¤ø,¸¸,ø¤º°\`°º¤ø,¸,ø¤°º¤ø,¸¸,ø¤º°\`°º¤ø,¸,ø¤°º¤ø,¸¸,ø¤º°\`°º¤ø,${NC}"
echo											   ##
echo											   ##
#############################################################################################
#############################################################################################
##                                                                                         ##
##                        General        Octopus        Settings                           ##
##                                                                                         ##
#############################################################################################
#############################################################################################




## Run Control Transitions
##-------------------------------------------------------------------------------------------
vme_poke 0x$hex_code\004600            ## Configure
##vme_poke 0x$hex_code\004604            ## Connect
##vme_poke 0x$hex_code\004608            ## Start
##vme_poke 0x$hex_code\00460C            ## Stop
##vme_poke 0x$hex_code\004610            ## Disconnect
##vme_poke 0x$hex_code\004614            ## Unconfigure





## Event Rate   (Number of Clock Cycles between Events)
##-------------------------------------------------------------------------------------------
echo Setting Event Rate
##vme_poke 0x$hex_code\004634 0xFFFF     ## 2.44 kHz (Slowest Speed)
##vme_poke 0x$hex_code\004634 0x3E7F     ##  10 kHz 
##vme_poke 0x$hex_code\004634 0x1F3F     ##  20 kHz
##vme_poke 0x$hex_code\004634 0x14D5     ##  30 kHz
##vme_poke 0x$hex_code\004634 0x0F9F     ##  40 kHz
vme_poke 0x$hex_code\004634 0x0C7F     ##  50 kHz
##vme_poke 0x$hex_code\004634 0x0A6A     ##  60 kHz
##vme_poke 0x$hex_code\004634 0x08ED     ##  70 kHz
##vme_poke 0x$hex_code\004634 0x07CF     ##  80 kHz
##vme_poke 0x$hex_code\004634 0x06F1     ##  90 kHz
# vme_poke 0x$hex_code\004634 0x063F     ## 100 kHz

# vme_poke 0x$hex_code\004694 0x0        ##  Run at selected rate
# vme_poke 0x$hex_code\004694 0x1        ##  overdrive (run at max rate)






## Lvl1ID   (Must prepare Test Vector correctly for dynamic functionality)
##-------------------------------------------------------------------------------------------
## word 0: bits[19:4] of word 0 are read in and used for trailer lvl1id write position
## word 1: idle or buffer word (c9c9c9bc1 or dead1d1e0 are typical)
## word 2: b0f0_xxxx   (EVENT HEADER)
echo Configuring lvl1ID Settings
##vme_poke 0x$hex_code\004630 0x0        ## Static Lvl1ID (read from file)
vme_poke 0x$hex_code\004630 0x1        ## Dynamic Lvl1ID (Incremental Counter)

vme_poke 0x$hex_code\004638 0x00000000 ## Initial Lvl1ID
##vme_poke 0x$hex_code\004638 0xc9c9c9bc ## Initial Lvl1ID
##vme_poke 0x$hex_code\004638 0xb0f00000 ## Initial Lvl1ID
##vme_poke 0x$hex_code\004638 0xe0da0000 ## Initial Lvl1ID







## PreScale    (Only send data on certain events, empty packets)
##-------------------------------------------------------------------------------------------
## bits[35:20] of word 6 are read in and used trailer write position
echo Configuring PreScale Settings

vme_poke 0x$hex_code\004690 0x00000007

##vme_poke 0x$hex_code\004690 0x00000000 ## Process All Events
##vme_poke 0x$hex_code\004690 0x00000001 ## Process Events divisible by 2
##vme_poke 0x$hex_code\004690 0x00000003 ## Process Events divisible by 4
##vme_poke 0x$hex_code\004690 0x00000007 ## Process Events divisible by 8
##vme_poke 0x$hex_code\004690 0xFFFFFFFF ## Process Only Event 00000000






## Data Format
##-------------------------------------------------------------------------------------------
## Low 4 Bits are data format ( 0 == EXTF_input, 1 == HW_input)
## High 4 Bits are Tentacle Number
echo Selecting Data Format

vme_poke 0x$hex_code\004678 0x00        ## Tentacle 0 will use Format 0
vme_poke 0x$hex_code\004678 0x10        ## Tentacle 1 will use Format 0
vme_poke 0x$hex_code\004678 0x20        ## Tentacle 2 will use Format 0
vme_poke 0x$hex_code\004678 0x30        ## Tentacle 3 will use Format 0
vme_poke 0x$hex_code\004678 0x40        ## Tentacle 4 will use Format 0
vme_poke 0x$hex_code\004678 0x50        ## Tentacle 5 will use Format 0
vme_poke 0x$hex_code\004678 0x60        ## Tentacle 6 will use Format 0
vme_poke 0x$hex_code\004678 0x70        ## Tentacle 7 will use Format 0





## Pseudo Data Mode  (Generate Data with N Tracks/Modules in it)
##-------------------------------------------------------------------------------------------
## Low 8 Bits are the number of tracks/modules
## High 4 Bits are Tentacle Number
echo Configuring Pseudo Data
vme_poke 0x$hex_code\004680 0x00        ## Pseudo Data Mode Off
##vme_poke 0x$hex_code\004680 0xFF        ## Pseudo Data Mode On

##vme_poke 0x$hex_code\004684 0x000      ## Number of Tracks/Modules to generate
##vme_poke 0x$hex_code\004684 0x100      ## Number of Tracks/Modules to generate
##vme_poke 0x$hex_code\004684 0x200      ## Number of Tracks/Modules to generate
##vme_poke 0x$hex_code\004684 0x300      ## Number of Tracks/Modules to generate
##vme_poke 0x$hex_code\004684 0x400      ## Number of Tracks/Modules to generate
##vme_poke 0x$hex_code\004684 0x500      ## Number of Tracks/Modules to generate
##vme_poke 0x$hex_code\004684 0x600      ## Number of Tracks/Modules to generate
##vme_poke 0x$hex_code\004684 0x700      ## Number of Tracks/Modules to generate





## Cycle Mode  (Multiple Events up to 16)
##-------------------------------------------------------------------------------------------
## Cycle Mode will start at TestVector 0 then 1, 2, 3 etc until N-1, then loop back to 0
echo Configuring Cycle Mode
vme_poke 0x$hex_code\004654 0x0        ## Cycle Mode Off
# vme_poke 0x$hex_code\004654 0x1        ## Cycle Mode On
# vme_poke 0x$hex_code\004658 0x8        ## Number of Events to Cycle (4 bits) cycle 0,1,..,N-1






## Pulse Mode  (Fire Events manually)
##-------------------------------------------------------------------------------------------
echo Configuring Pulse Mode 
vme_poke 0x$hex_code\004640 0x0        ## Pulse Mode Off -- Continuous Tracks
# vme_poke 0x$hex_code\004640 0x1        ## Pulse Mode On
#vme_poke 0x$hex_code\004644 0x0001     ## Fire Pulse of N events (16 bits)






## Backpressure Settings
##-------------------------------------------------------------------------------------------
echo Configuring Backpressure Settings
vme_poke 0x$hex_code\004660 0x0        ## Respect Backpressure
##vme_poke 0x$hex_code\004660 0x1        ## Ignore Backpressure -- Test Mode

# vme_poke 0x$hex_code\004668 0x00       ## Stop after completing current packet             (1 bit/tentacle)
vme_poke 0x$hex_code\004668 0xFF       ## Stop immediately in the middle of current packet (1 bit/tentacle)






## Change Selected Test Vectors
##-------------------------------------------------------------------------------------------
## Low 4 Bits are Test Vector Number
## High 4 Bits are Tentacle Number
echo Selecting Test Vectors
vme_poke 0x$hex_code\004650 0x02         ## Change Tentacle 0 to Test Vector 0
vme_poke 0x$hex_code\004650 0x10         ## Change Tentacle 1 to Test Vector 0
vme_poke 0x$hex_code\004650 0x22         ## Change Tentacle 2 to Test Vector 0
vme_poke 0x$hex_code\004650 0x30         ## Change Tentacle 3 to Test Vector 0
vme_poke 0x$hex_code\004650 0x40         ## Change Tentacle 4 to Test Vector 0
vme_poke 0x$hex_code\004650 0x50         ## Change Tentacle 5 to Test Vector 0
vme_poke 0x$hex_code\004650 0x60         ## Change Tentacle 6 to Test Vector 0
vme_poke 0x$hex_code\004650 0x70         ## Change Tentacle 7 to Test Vector 0






## Change Transmitted Idle Words (isaux)
##-------------------------------------------------------------------------------------------
## Low 4 Bits are isaux ( 0 == DF___C5C5C5BC, 1 == AUX__0000BCC5, 2 == SSB__C9C9C9BC)
## High 4 Bits are Tentacle Number
echo Configuring Transmitted Idle Words
##vme_poke 0x$hex_code\004670 0x00         ## Change Tentacle 0 to DF  (C5C5C5BC)
##vme_poke 0x$hex_code\004670 0x10         ## Change Tentacle 1 to DF  (C5C5C5BC)
##vme_poke 0x$hex_code\004670 0x21         ## Change Tentacle 2 to AUX (0000BCC5)
##vme_poke 0x$hex_code\004670 0x31         ## Change Tentacle 3 to AUX (0000BCC5)
##vme_poke 0x$hex_code\004670 0x40         ## Change Tentacle 4 to DF  (C5C5C5BC)
##vme_poke 0x$hex_code\004670 0x50         ## Change Tentacle 5 to DF  (C5C5C5BC)
##vme_poke 0x$hex_code\004670 0x61         ## Change Tentacle 6 to AUX (0000BCC5)
##vme_poke 0x$hex_code\004670 0x71         ## Change Tentacle 7 to AUX (0000BCC5)
vme_poke 0x$hex_code\004670 0x02         ## Change Tentacle 0 to SSB (C9C9C9BC)
vme_poke 0x$hex_code\004670 0x12         ## Change Tentacle 1 to SSB (C9C9C9BC)
vme_poke 0x$hex_code\004670 0x22         ## Change Tentacle 2 to SSB (C9C9C9BC)
vme_poke 0x$hex_code\004670 0x32         ## Change Tentacle 3 to SSB (C9C9C9BC)
vme_poke 0x$hex_code\004670 0x42         ## Change Tentacle 4 to SSB (C9C9C9BC)
vme_poke 0x$hex_code\004670 0x52         ## Change Tentacle 5 to SSB (C9C9C9BC)
vme_poke 0x$hex_code\004670 0x62         ## Change Tentacle 6 to SSB (C9C9C9BC)
vme_poke 0x$hex_code\004670 0x72         ## Change Tentacle 7 to SSB (C9C9C9BC)






## Add Latency
##-------------------------------------------------------------------------------------------
## Low 28 Bits are the number of clock cycles of latency to be added to the tentacle
## High 4 Bits are Tentacle Number
echo Adding Tentacle Latency
vme_poke 0x$hex_code\004674 0x00000000         ## Add 3E8 clock cycles of latency to Tentacle 0
vme_poke 0x$hex_code\004674 0x10000000         ## Add 3E8 clock cycles of latency to Tentacle 1
#vme_poke 0x$hex_code\004674 0x20000000         ## Add 3E8 clock cycles of latency to Tentacle 2
#vme_poke 0x$hex_code\004674 0x30000000         ## Add 3E8 clock cycles of latency to Tentacle 3
vme_poke 0x$hex_code\004674 0x20000020         ## Add 3E8 clock cycles of latency to Tentacle 2
vme_poke 0x$hex_code\004674 0x30000000         ## Add 3E8 clock cycles of latency to Tentacle 3
vme_poke 0x$hex_code\004674 0x40000000         ## Add 3E8 clock cycles of latency to Tentacle 4
vme_poke 0x$hex_code\004674 0x50000000         ## Add 3E8 clock cycles of latency to Tentacle 5
vme_poke 0x$hex_code\004674 0x60000000         ## Add 3E8 clock cycles of latency to Tentacle 6
vme_poke 0x$hex_code\004674 0x70000000         ## Add 3E8 clock cycles of latency to Tentacle 7


##ssb_octopus_load_app --slot $1 --tentacle 0 --vector 0 --file /afs/cern.ch/user/m/matkinso/public/FTK/TestVectors/dfa_module_test.txt


echo
echo
#############################################################################################
#############################################################################################
##                                                                                         ##
##                                Test            Vectors                                  ##
##                                                                                         ##
#############################################################################################
#############################################################################################
if [ "$#" -eq "1" ]                          ## Loading is Bypassed using the fast option
then                                         ## ./configure_octopus.sh 6 fast 
echo -e "${PUR}¤ø,¸,ø¤°º¤ø,¸¸,ø¤º°\`°º¤ø,¸,ø¤°º¤ø,¸¸,ø¤º°\`°º¤ø,¸,ø¤°º¤ø,¸¸,ø¤º°\`°º¤ø,${NC}"
echo Loading Test Vectors
echo -e "${PUR}¤ø,¸,ø¤°º¤ø,¸¸,ø¤º°\`°º¤ø,¸,ø¤°º¤ø,¸¸,ø¤º°\`°º¤ø,¸,ø¤°º¤ø,¸¸,ø¤º°\`°º¤ø,${NC}"
echo
echo

##### 9 Test Vectors taken from P1 data #####
ssb_octopus_load_app --slot $1 --tentacle 0 --vector 0 --file /afs/cern.ch/user/c/cgentsos/public/Octopus/df_stream32_empty.dat
ssb_octopus_load_app --slot $1 --tentacle 0 --vector 1 --file /afs/cern.ch/user/m/matkinso/public/FTK/TestVectors/df_stream32_test4_vector2.txt
ssb_octopus_load_app --slot $1 --tentacle 0 --vector 2 --file /afs/cern.ch/user/c/cgentsos/public/Octopus/tv_octopus_2018-01-11_df_1.dat
ssb_octopus_load_app --slot $1 --tentacle 0 --vector 3 --file /afs/cern.ch/user/c/cgentsos/public/Octopus/tv_octopus_2018-01-12_df_1.dat
ssb_octopus_load_app --slot $1 --tentacle 0 --vector 4 --file /afs/cern.ch/user/c/cgentsos/public/Octopus/test_vector_df_30.dat
ssb_octopus_load_app --slot $1 --tentacle 0 --vector 5 --file /afs/cern.ch/user/c/cgentsos/public/Octopus/test_vector_df_11.dat
ssb_octopus_load_app --slot $1 --tentacle 0 --vector 6 --file /afs/cern.ch/work/j/jzeng/public/ssb/ssb_22/inputDF.dat
ssb_octopus_load_app --slot $1 --tentacle 0 --vector 7 --file /afs/cern.ch/user/m/matkinso/public/FTK/TestVectors/df_stream32_test4_vector9.txt
ssb_octopus_load_app --slot $1 --tentacle 1 --vector 0 --file idle_c9c9c9bc.txt
ssb_octopus_load_app --slot $1 --tentacle 1 --vector 1 --file idle_c9c9c9bc.txt
ssb_octopus_load_app --slot $1 --tentacle 1 --vector 2 --file idle_c9c9c9bc.txt
ssb_octopus_load_app --slot $1 --tentacle 1 --vector 3 --file idle_c9c9c9bc.txt
ssb_octopus_load_app --slot $1 --tentacle 1 --vector 4 --file idle_c9c9c9bc.txt
ssb_octopus_load_app --slot $1 --tentacle 1 --vector 5 --file idle_c9c9c9bc.txt
ssb_octopus_load_app --slot $1 --tentacle 1 --vector 6 --file idle_c9c9c9bc.txt
ssb_octopus_load_app --slot $1 --tentacle 1 --vector 7 --file idle_c9c9c9bc.txt
ssb_octopus_load_app --slot $1 --tentacle 2 --vector 0 --file /afs/cern.ch/user/c/cgentsos/public/Octopus/aux_stream32_empty.dat
ssb_octopus_load_app --slot $1 --tentacle 2 --vector 1 --file /afs/cern.ch/user/m/matkinso/public/FTK/TestVectors/aux_stream32_test4_vector2.txt
ssb_octopus_load_app --slot $1 --tentacle 2 --vector 2 --file /afs/cern.ch/user/c/cgentsos/public/Octopus/tv_octopus_2018-01-11_aux_1.dat
ssb_octopus_load_app --slot $1 --tentacle 2 --vector 3 --file /afs/cern.ch/user/c/cgentsos/public/Octopus/tv_octopus_2018-01-12_aux_1.dat
ssb_octopus_load_app --slot $1 --tentacle 2 --vector 4 --file /afs/cern.ch/user/c/cgentsos/public/Octopus/test_vector_aux_30.dat
ssb_octopus_load_app --slot $1 --tentacle 2 --vector 5 --file /afs/cern.ch/user/c/cgentsos/public/Octopus/test_vector_aux_11.dat
ssb_octopus_load_app --slot $1 --tentacle 2 --vector 6 --file /afs/cern.ch/work/j/jzeng/public/ssb/ssb_22/inputAUX.dat
ssb_octopus_load_app --slot $1 --tentacle 2 --vector 7 --file /afs/cern.ch/user/m/matkinso/public/FTK/TestVectors/aux_stream32_test4_vector9.txt
ssb_octopus_load_app --slot $1 --tentacle 3 --vector 0 --file idle_c9c9c9bc.txt
ssb_octopus_load_app --slot $1 --tentacle 3 --vector 1 --file idle_c9c9c9bc.txt
ssb_octopus_load_app --slot $1 --tentacle 3 --vector 2 --file idle_c9c9c9bc.txt
ssb_octopus_load_app --slot $1 --tentacle 3 --vector 3 --file idle_c9c9c9bc.txt
ssb_octopus_load_app --slot $1 --tentacle 3 --vector 4 --file idle_c9c9c9bc.txt
ssb_octopus_load_app --slot $1 --tentacle 3 --vector 5 --file idle_c9c9c9bc.txt
ssb_octopus_load_app --slot $1 --tentacle 3 --vector 6 --file idle_c9c9c9bc.txt
ssb_octopus_load_app --slot $1 --tentacle 3 --vector 7 --file idle_c9c9c9bc.txt



echo
echo
echo -e "${PUR}¤ø,¸,ø¤°º¤ø,¸¸,ø¤º°\`°º¤ø,¸,ø¤°º¤ø,¸¸,ø¤º°\`°º¤ø,¸,ø¤°º¤ø,¸¸,ø¤º°\`°º¤ø,${NC}"
echo Done Loading Test Vectors
fi

echo -e "${PUR}¤ø,¸,ø¤°º¤ø,¸¸,ø¤º°\`°º¤ø,¸,ø¤°º¤ø,¸¸,ø¤º°\`°º¤ø,¸,ø¤°º¤ø,¸¸,ø¤º°\`°º¤ø,${NC}"
echo
echo
echo
echo -e "${PUR}                              ___                               ${NC}"
echo -e "${PUR}                           .-'   \`'.				${NC}"
echo -e "${PUR}                          /         \				${NC}"
echo -e "${PUR}                          |         ;				${NC}"
echo -e "${PUR}                          |         |           ___.--,		${NC}"
echo -e "${PUR}                 _.._     |0) ~ (0) |    _.---'\`__.-( (_.	${NC}"
echo -e "${PUR}          __.--'\`_.. '.__.\    '--. \_.-' ,.--'\`     \`\"\"\`	${NC}"
echo -e "${PUR}         ( ,.--'\`   ',__ /./;   ;, '.__.'\`    __		${NC}"
echo -e "${PUR}         _\`) )  .---.__.' / |   |\   \__..--\"\"  \"\"\"--.,_	${NC}"
echo -e "${PUR}        \`---' .'.''-._.-'\`_./  /\ '.  \ _.-~~~\`\`\`\`~~~-._\`-.__.'	${NC}"
echo -e "${PUR}              | |  .' _.-' |  |  \  \  '.               \`~---\`     ${NC}"
echo -e "${PUR}               \ \/ .'     \  \   '. '-._)			${NC}"
echo -e "${PUR}                \/ /        \  \    \`=.__\`~-.			${NC}"
echo -e "${PUR}                / /\         \`) )    / / \`\"\".\`\			${NC}"
echo -e "${PUR}          , _.-'.'\ \        / /    ( (     / /			${NC}"
echo -e "${PUR}           \`--~\`   ) )    .-'.'      '.'.  | (			${NC}"
echo -e "${PUR}                  (/\`    ( (\`          ) )  '-;			${NC}"
echo -e "${PUR}                   \`      '-;         (-'                       ${NC}"    
echo
echo

exit 0


## IM runs 3.1 Gbps
