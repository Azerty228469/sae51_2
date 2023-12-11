FROM ubuntu:22.04

#Paquets nécessaires pour sauvegarde cron
RUN apt-get update && apt-get upgrade -y
RUN apt-get install mysql-client -y
RUN apt-get install cron -y

#Definition emplacement tâches cron
COPY cron/crontabs /crontabs
RUN crontab /crontabs

#Copie script de sauvegarde
COPY cron/cron_sauvegarde.sh /cron_sauvegarde.sh

#Lancement cron au démarrage
CMD ["cron", "-f"]