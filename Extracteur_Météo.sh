#!/bin/bash

VILLE_DEFAUT="Lyon"

if [ -z "$1" ]; then
	VILLE=$VILLE_DEFAUT	#je dois mettre la ville défaut ici sinon j'aurais le message qu'il faut une ville en parametre
else
	VILLE="$1"
fi

HISTORIQUE_FICHIER="meteo_$(date +%Y%m%d).txt"
FICHIER="meteo.txt"

curl -s "wttr.in/$VILLE?format=%C+%t" > meteo_temp.txt

TEMP_ACTUELLE=$(grep -Eo '[-+]\d+°C' meteo_temp.txt | head -n 1)
TEMP_PREVISION=$(curl -s "wttr.in/$VILLE?format=3" | grep -Eo '[-+]\d+°C')

DATE=$(date +"%Y-%m-%d")
HEURE=$(date +"%H:%M")

echo "$DATE - $HEURE - $VILLE : $TEMP_ACTUELLE - $TEMP_PREVISION" >> $FICHIER
echo "Les données météo ont été enregistrées dans $FICHIER"

echo "$DATE - $HEURE - $VILLE : $TEMP_ACTUELLE - $TEMP_PREVISION" >> "$HISTORIQUE_FICHIER"
