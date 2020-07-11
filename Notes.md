# Oracle & connection <-> ora2pg
## Asumptions, Questions & Concers
* For this ANZ case, does the API on top of the Oracle schemas run in GCP say cloud function? If yes, can we spin up our ora2pg instance within the same setup (same VPC, Firewall rules etc.)?
* Is downtime tolerable? Is CDC a must?
* Is there any reliance on oracle proprietary features?(e.g. pl sql synonym)
## General goal
* Spin up a GCE instance and enable it to connect connect to an oracle DB configured on another box via CLI
* General Dependencies:
    * Oracle Client
        * instantclient-basic-linux.x64-19.6.0.0.0dbru.zip
        * instantclient-sqlplus-linux.x64-19.6.0.0.0dbru.zip
        * instantclient-jdbc-linux.x64-19.6.0.0.0dbru.zip
        * instantclient-sdk-linux.x64-19.6.0.0.0dbru.zip
    * Environment variable:
        * export LD_LIBRARY_PATH=/home/<path_to_unzip_location>/instantclient_19_6
        * export ORACLE_HOME=/home/<path_to_unzip_location>/instantclient_19_6

## Option 1: local installation and expose IP&port to public
* configure port forwarding on local side, or
* Use tools like ngrok to generate a url to expose public_ip:1521
    * Successful: However cannot make ora2pg to talk to url which is pointing to a specific port already. Dependencies:
        * Hosting side: ngrok tcp 1521
        * Enforce encoding: export NLS_LANG=american_america.zhs16gbk
        * $ORACLE_HOME/sqlplus <user_name>/<password>@<ngrok_url>/<SID>
## Option 2: Spin up a cloud based oracle instance in AWS or Oracle cloud
* AWS RDS has this managed service, Oracle Cloud provide Free tier and $400 credit 
    * Succesfully got an GCE instance to connect to a oracle@RDS via sqlplus tool: 
        * $ORACLE_HOME/sqlplus <user_name>/<password>@<endpoint>:<port>/<SID>
    
# ora2pg
## Overview
* Based on Perl DBI so capable of connection to DB directly, or creating dump file in different formats
* Additional dependancies: 
    * Perl 5.6+ 
    * Perl DBI: apt-get install libdbi-perl
    * DBD::Oracle Perl modules (part of the installation)
    * apt-get install build-essential
    * apt-get install make
    * apt-get install libaio1 libaio-dev
* Features:
    * 
# Postgresql on CloudSQL

# Ideas!
* Create a golden image for this ora2pd tool which can be spun up with a script
* Possibility of GKE hosting?
    * Benifit can be quick code start time?
* Explore Migvisor and Striim 