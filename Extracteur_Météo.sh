#!/bin/bash

VILLE_DEFAUT="Lyon"

if [ -z "$1" ]; then
	VILLE=$VILLE_DEFAUT	#je dois mettre la ville défaut ici sinon j'aurais le message qu'il faut une ville en parametre
else
	VILLE="$1"
fi

#j'ajoute la variante 2 pour l'option de sauvegarde avec JSON
JSON=false
if [ "$2" == "--json" ]; then
    JSON=true
fi

HISTORIQUE_FICHIER="meteo_$(date +%Y%m%d).txt"
FICHIER="meteo.txt"

#ajour d'un nouveau fichier JSON
JSON="meteo_$(date +%Y%m%d).json"

#ajour d'un nouveau fichier pour les erreurs
ERREUR="meteo_error.log"

#si il y a une erreur pour ce connexter a wttr.in cela va afficher un message d'erreur
if ! curl -s "wttr.in/$VILLE?format=%C+%t+%w+%h+%v" > meteo_temp.txt; then
    echo "Pas possible de se connexter a wttr.in pour $VILLE que vous aviez demandé" >> $ERREUR
    echo "Une erreur de connexion a été enregistrée dans $ERREUR"
    exit 1
fi

TEMP_ACTUELLE=$(grep -Eo '[-+]\d+°C' meteo_temp.txt | head -n 1)
TEMP_PREVISION=$(curl -s "wttr.in/$VILLE?format=3" | grep -Eo '[-+]\d+°C')

DATE=$(date +"%Y-%m-%d")
HEURE=$(date +"%H:%M")
#j'ajoute la variante 1 pour savoir le vent, l'humidité et la visibilité de la ville
VENT=$(grep -Eo '[0-9]+ km/h' meteo_temp.txt | head -n 1)
HUMIDITE=$(grep -Eo '[0-9]+%' meteo_temp.txt | head -n 1)
VISIBILITE=$(grep -Eo '[0-9]+ km' meteo_temp.txt | head -n 1)

if [ "$JSON" = true ]; then
    
	echo "{
	\"date\": \"$DATE\",	
	\"heure\": \"$HEURE\",
	\"ville\": \"$VILLE\",
	\"temperature\": \"$TEMP_ACTUELLE\",
	\"vent\": \"$VENT\",
	\"humidite\": \"$HUMIDITE\",
	\"visibilite\": \"$VISIBILITE\"
}" >> meteo.txt
	echo "Les données météo ont été enregistrées en JSON dans $JSON"
else
#je rajoute les nouvelles données dans le echo 
	echo "$DATE - $HEURE - $VILLE : $TEMP_ACTUELLE - $TEMP_PREVISION - $VENT - $HUMIDITE - $VISIBILITE" >> $FICHIER
	echo "Les données météo ont été enregistrées dans $FICHIER"
	echo "$DATE - $HEURE - $VILLE : $TEMP_ACTUELLE - $TEMP_PREVISION- $VENT - $HUMIDITE - $VISIBILITE" >> "$HISTORIQUE_FICHIER"
fi
