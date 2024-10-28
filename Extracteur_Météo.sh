#!/bin/bash

if [ -z "$1" ]; then
	VILLE="PARIS"	#je dois mettre la ville défaut ici sinon j'aurais le message qu'il faut une ville en parametre
else
	VILLE="$1"
fi

FICHIER="meteo.txt"

curl -s "wttr.in/$VILLE?format=%C+%t" > meteo_temp.txt

TEMP_ACTUELLE=$(grep -oP '[-+]\d+°C' meteo_temp.txt | head -n 1)
TEMP_PREVISION=$(curl -s "wttr.in/$VILLE?format=3" | grep -oP '[-+]\d+°C')

DATE=$(date +"%Y-%m-%d")
HEURE=$(date +"%H:%M")

echo "$DATE - $HEURE - $VILLE : $TEMP_ACTUELLE - $TEMP_PREVISION" >> $FICHIER
