echo Stopping Octopus
vme_poke 0x2000460c
sleep 1
vme_poke 0x20004610
vme_poke 0x20004614


echo Stopping EXTF0
vme_poke 0x3800060c
sleep 1
vme_poke 0x38000610
vme_poke 0x38000614


#echo Stopping EXTF2
#vme_poke 0x3800260c
#sleep 1
#vme_poke 0x38002610
#vme_poke 0x38002614

echo Stopping HW
vme_poke 0x3800460c
sleep 1
vme_poke 0x38004610
vme_poke 0x38004614
