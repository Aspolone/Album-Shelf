#!/bin/bash
set -e

PROGETTO="$(dirname "$0")"
cd "$PROGETTO"

CARTELLA_UPLOAD="/home/escanor/albumshelf-uploads"

echo "== drop + ricreazione database =="
sudo mariadb -u root -p -e "DROP DATABASE IF EXISTS albumshelf_db;"

echo "== schema =="
sudo mariadb -u root -p < db/schema.sql

echo "== dati di esempio =="
sudo mariadb -u root -p < db/popolamento_schema.sql

echo "fatto. nessun redeploy necessario: database e immagini sono indipendenti da Tomcat."
