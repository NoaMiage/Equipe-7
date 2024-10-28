#!/bin/bash

VILLE=${1:-Paris}  #on prend la ville de Paris comme exemple si aucune ville n'est donné
FICHIER="meteo.txt"

curl -s "wttr.in/$VILLE?format=%C+%t" > meteo_temp.txt

TEMP_ACTUELLE=$(grep -oP '[-+]\d+°C' meteo_temp.txt | head -n 1)
TEMP_PREVISION=$(curl -s "wttr.in/$VILLE?format=3" | grep -oP '[-+]\d+°C')

DATE=$(date +"%Y-%m-%d")
HEURE=$(date +"%H:%M")

echo "$DATE - $HEURE - $VILLE : $TEMP_ACTUELLE - $TEMP_PREVISION" >> $FICHIER

echo "Les données météo ont été enregistrées dans $FICHIER"
