#!/bin/sh
clear
echo "Starting... "
DIALOG=${DIALOG=dialog}
compteur=0
(
while test $compteur != 90
do
compteur=`expr $compteur + 1`

reste=$(( 90-$compteur ))
echo $(( $compteur*100/90 ))
echo "XXX"
echo "Il vous reste $reste secondes $x "
echo "
.............................._--_...............................
.............................|o_o.|..............................
.............................|:_/.|..............................
............................//...\.\.............................
...........................(|.....|.)............................
.........................../'\_..._/'\...........................
...........................\___)=(___/...........................
"
echo "XXX"
sleep 1
done
) |
$DIALOG --title "Mon Processeus" --gauge "Bonjour, ceci est une barre d'avancement" 20 70 0
