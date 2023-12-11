#!/bin/bash

mysqldump -u dolibarr -p'dolibarr' -h MySQL --port=4124 dolibarr > /var/www/documents/sauvegarde.sql