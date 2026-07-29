#!/bin/bash
set -e

export CATALINA_HOME=/home/escanor/tomcat/apache-tomcat-11.0.24

PROGETTO="$(dirname "$0")"
cd "$PROGETTO"

echo "== 1/5 build maven =="
mvn clean package -q

echo "== 2/5 stop tomcat =="
"$CATALINA_HOME/bin/shutdown.sh" || true
sleep 2

echo "== 3/5 rimuovo vecchio deploy =="
rm -rf "$CATALINA_HOME/webapps/albumshelf"
rm -f  "$CATALINA_HOME/webapps/albumshelf.war"

echo "== 4/5 copio nuovo war =="
cp target/*.war "$CATALINA_HOME/webapps/albumshelf.war"

echo "== 5/5 avvio tomcat =="
"$CATALINA_HOME/bin/startup.sh"

echo "fatto. aspetta qualche secondo prima di testare."
