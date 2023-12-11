#!/bin/bash

#Création volumes à lier
docker volume create dolibarr_bdd
docker volume create dolibarr_documents

docker network create SAE51_2

#Lancement docker MySQL
docker run --name MySQL \
	-p 4124:4124 \
	-v dolibarr_bdd:/var/lib/mysql \
	--env MYSQL_ROOT_PASSWORD=root \
	--env MYSQL_DATABASE=dolibarr \
	--env MYSQL_USER=dolibarr \
	--env MYSQL_PASSWORD=dolibarr \
	--env character-set-client=utf8 \
	--network=SAE51_2 \
	-d mysql

#Attendre 15 secondes le lancement
echo "*********************ATTENTE DE 15 SECONDES*********************"
sleep 15

#Création de la BDD par le script 'create_database.sql'
mysql -u dolibarr -p'dolibarr' -h 127.0.0.1 --port=4124 < sql/create_database.sql
./data_import.sh

#Lancement docker Dolibarr
docker run --name Dolibarr \
	-p 80:80 \
	--env DOLI_DB_NAME=dolibarr \
	--env DOLI_DB_HOST=MySQL -d \
	--env DOLI_ADMIN_LOGIN=dolibarr\
	--env DOLI_ADMIN_PASSWORD=dolibarr\
	--env DOLI_MODULES=modSociete\
	--network=SAE51_2 \
	tuxgasy/dolibarr

#Création docker Cron
docker build -t cron -f cron/Dockerfile .

#Lancement docker Cron
docker run --name Cron_sauvegarde \
	-v dolibarr_documents:/var/www/documents \
	--network=SAE51_2 \
	-d cron