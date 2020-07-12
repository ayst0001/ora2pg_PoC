#!/bin/bash

#CONFIG_FILE=$1

S$TAGING_BUCKET=gs://ora2pg_poc_staging

#Just in casere-exporting environmet variable for oracle client is required
#export LD_LIBRARY_PATH=/home/ayst0001/packages/instantclient_19_6
#export ORACLE_HOME=/home/ayst0001/packages/instantclient_19_6

if [ "$1" = "" ]; then
    echo "Please specify the name of config file placed in ora2pg_configs!"
    exit
else
    echo "Using config file: "$1
fi

/usr/local/bin/ora2pg -c ../ora2pg_configs/$1 -d

echo "Uploading output file to staging bucket: "$STAGING_BUCKET
gsutil cp *.sql gs://ora2pg_poc_staging/
