# Equipe-7

Comment se servir de cron :
Pour automatiser l'exécution de scripts, on utilise un planificateur de tâches appelé cron. Il est nécessaire que cron soit installé et dispose des permissions nécessaires pour fonctionner correctement.

Étape 1 : Ouvrir le fichier crontab
Pour configurer une tâche cron, commencez par ouvrir le fichier crontab (fichier des tâches planifiées pour l’utilisateur) en tapant la commande suivante dans le terminal :
crontab -e

Étape 2 : Comprendre la syntaxe de cron
Dans notre exemple, nous souhaitons actualiser les données toutes les heures. Pour cela, il est important de comprendre la signification des étoiles (*) dans la commande cron, car elles permettent de définir la fréquence de la tâche.
Cela se compose de cinq champs suivis de la commande à exécuter :
* * * * * /Equipe-7/Extracteur_Météo.sh
La première étoile sert pour les minutes, la deuxièmes pour les heures, la troisième pour les jours du mois, la quatrième pour les mois de l'année et la dernière pour les jours de la semaine ( a savoir pour le dimanche il y a deux chiffres possibles le 0 et le 7).

Étape 3 : Configurer la tâche pour une actualisation toutes les heures
Pour que les données soient actualisées toutes les heures, nous allons utiliser la configuration suivante dans le fichier crontab :
0 * * * * /Equipe-7/Extracteur_Météo.sh
0 signifie que la tâche se déclenchera à la 0ᵉ minute de chaque heure.
Dans notre exemple, nous utilisons /Equipe-7/Extracteur_Météo.sh, ce qui indique le chemin où est stocké notre script. 

Enregistrement et Confirmation
1. Enregistrer et quitter l’éditeur de crontab pour activer la nouvelle tâche planifiée.
    * Si vous utilisez nano, sauvegardez avec Ctrl + O, puis quittez avec Ctrl + X.
    * Si vous utilisez autre chose, enregistrez et quittez avec :wq
2. Vérifier les tâches cron :
    * Pour afficher toutes les tâches planifiées, utilisez la commande :
       crontab -l 
