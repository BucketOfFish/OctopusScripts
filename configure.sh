#!/bin/bash

## Check if the arguments are valid
if [ "$#" -lt "0" ] || [ "$#" -gt "1" ]
then
    echo
    echo Incorrect number of arguments
    echo
    echo OPTIONAL PARAMETER 1: To disable the loading of Test Vectors use the fast option 
    echo "EXAMPLE:     ./configure.sh         ## Configure and Load" 
    echo "EXAMPLE:     ./configure.sh fast    ## Configure Only"
    echo
    exit 1
fi
if [ "$#" -eq "1" ] && [ "$1" != "fast" ]
then
    echo
    echo Unrecognized parameter $1
    echo
    echo OPTIONAL PARAMETER 1: To disable the loading of Test Vectors use the fast option 
    echo "EXAMPLE:     ./configure.sh         ## Configure and Load" 
    echo "EXAMPLE:     ./configure.sh fast    ## Configure Only"
    echo
    exit 1
fi


./configure_octopus.sh 4 $1
./configure_extf.sh 7 0 $1
vme_poke 0x38004600 # first two digits = slot number (see L45-60 in configure_octopus.sh)
