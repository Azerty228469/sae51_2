#!/bin/bash

#Suppression contenu BDD
mysql -u dolibarr -p'dolibarr' -h 127.0.0.1 --port=4124 dolibarr < "sql/purge.sql"

#Arrêt dockers
docker stop MySQL
docker stop Dolibarr
docker stop Cron_sauvegarde

#Suppression dockers
docker rm MySQL
docker rm Dolibarr
docker rm Cron_sauvegarde

#Suppression réseau
docker network rm SAE51_2