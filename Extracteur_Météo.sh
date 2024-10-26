#!/bin/bash

# Vérifier que l'utilisateur a passé un argument (le nom de la ville)
if [ -z "$1" ]; then
    echo "Veuillez spécifier le nom d'une ville."
    exit 1
fi

VILLE=$1
FICHIER="meteo.txt"

# Récupérer les données météo brutes et les enregistrer dans un fichier temporaire
curl -s "wttr.in/$VILLE?format=%C+%t" > meteo_temp.txt

# Extraire la température actuelle
TEMP_ACTUELLE=$(grep -oP '[-+]\d+°C' meteo_temp.txt | head -n 1)

# Récupérer la prévision pour le lendemain
TEMP_PREVISION=$(curl -s "wttr.in/$VILLE?format=3" | grep -oP '[-+]\d+°C')

# Obtenir la date et l'heure actuelles
DATE=$(date +"%Y-%m-%d")
HEURE=$(date +"%H:%M")

# Formater et enregistrer les informations dans le fichier meteo.txt
echo "$DATE - $HEURE - $VILLE : $TEMP_ACTUELLE - $TEMP_PREVISION" > $FICHIER

echo "Les données météo ont été enregistrées dans $FICHIER"
