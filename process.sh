#! /bin/bash


DIALOG=${DIALOG=dialog}

$DIALOG --title " Gestion des Processus " --clear \
	--yesno "Bonjour, ceci est script de gestion de processus \n Voulez vous continuer ?" 10 30

case $? in
	0)	gnome-terminal ; ptss=$( ls /dev/pts/ | sort -r |head -2 | tail -1 )  ;;
	1)	exit ;;
	255)	echo "Appuyé sur Echap. ";;
esac

while 
    [ 1 ]
do

 fichtemp=`tempfile 2>/dev/null` || fichtemp=/tmp/test$$
trap "rm -f $fichtemp" 0 1 2 5 15
$DIALOG --clear --title " Gestion des Processus " \
	--menu "Bonjour, choisissez votre commande : \n ${msg}" 20 51 4 \
    "0" "Quitter" \
    "1" "Lancer le process " \
    "2" "Terminer le process  " \
    "3" "Stopper le process  " \
    "4" "Continuer le process " \
    "5" "Ouvrir le process dans une autre fenetre " \
    "6" "Afficher les infromations de process " \
    "7" "afficher la liste de mes process " 2> $fichtemp 
valret=$?
choix=`cat $fichtemp`
case $valret in
 0)	
 
 if [ $choix -eq 0 ]
then
exit

elif [ $choix -eq 1 ]
then
#gnome-terminal
#ptss=$( ls /dev/pts/ | sort -r |head -2 | tail -1 )
#pi=$(./childProcess.sh  > /dev/pts/$ptss &  echo $! ) 
./childProcess.sh  > /dev/pts/$ptss &

msg="Your Process Started in pts${ptss} "
export msg
elif [ $choix -eq 2 ] 
then
pi1=$(ps -e | grep childProcess | cut -d"p"  -f1)
echo $pi1 |xargs kill -9 
msg="Processus Terminé"

elif [ $choix -eq 3 ]
then

#id= ps -ef | grep 'process1' |  awk '{printf("%d", $PID)}'

pi1=$(ps -e | grep childProcess | cut -d"p"  -f1)
echo $pi1 |xargs kill -19 
msg="Processus Stoppé"
elif [ $choix -eq 4 ]
then
pi1=$(ps -e | grep childProcess | cut -d"p"  -f1)
echo $pi1 |xargs kill -18 

msg="Retour de Processus"
elif [ $choix -eq 5 ]
then

DIALOG=${DIALOG=dialog}
fichtemp=`tempfile 2>/dev/null` || fichtemp=/tmp/test$$
trap "rm -f $fichtemp" 0 1 2 5 15
$DIALOG --title " Gestion des Processus " --clear \
        --inputbox "Les Fenetres: \n $(ls -I ptmx /dev/pts) \n Donner le numero de fenetre" 16 51 2> $fichtemp

valret=$?

case $valret in
  0)
  ./childProcess.sh  > /dev/pts/`cat $fichtemp` &

msg="Your Process Started in pts$`cat $fichtemp` "
export msg ;;
  1)
    echo "Appuyé sur Annuler.";;
  255)
    if test -s $fichtemp ; then
        cat $fichtemp
    else
        echo "Appuyé sur Echap."
    fi
    ;;
esac

#echo Les Fenetres: 
#ls -I ptmx /dev/pts
#echo "Donner le numero de fenetre"
#read num
#pi=$(~/process1 > /dev/pts/$num &  echo $!)
#echo Your Process Started in pts$num with id=$pi ...

elif [ $choix -eq 6 ]
then
pitemp=$(echo $pi1 | awk '{ print $NF }')
 top -p $pitemp
msg=$pitemp

elif [ $choix -eq 7 ]
then
msg=""
top | grep $(whoami)




fi


 ;;
 1) 	exit ;;
255) 	exit ;;
esac

done

