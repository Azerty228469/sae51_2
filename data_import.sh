#!/bin/bash

tail "data.csv" | while IFS="," read -r version type subtype label account_parent;
do
	mysql -u dolibarr -p'dolibarr' -h 127.0.0.1 --port=4124 dolibarr << Insert
	INSERT INTO llx_accounting_account (fk_pcg_version, pcg_type, pcg_subtype, label, account_parent)
	VALUES ('$version', '$type', '$subtype', '$label', '$account_parent');
Insert

done
