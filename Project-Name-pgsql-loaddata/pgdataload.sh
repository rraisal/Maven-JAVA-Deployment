#!/bin/bash

DB_HOST=${DB_HOST:-postgres}
DB_PORT=${DB_PORT:-5432}
DB_NAME=${DB_NAME:-XXXX}
DB_USER=${DB_USER:-XXXX}
DB_PASS=${DB_PASS:-XXXX}

wait_for_dependency_service(){
  echo "[INFO]: Checking PostgreSQL Port";
  while ! nc -z postgres 5432; do sleep 3; done
  echo "[INFO]: PostgreSQL Port Available";
}

run_liquibase(){

if [ ! -z "$DB_HOST" ] || [ ! -z "$DB_NAME" ] || [ ! -z "$DB_USER" ] || [ ! -z "$DB_PASS" ]; then
echo "[INFO]: Initiated Liquibase";
wait_for_dependency_service

java -jar /opt/liquibase.jar --classpath=/opt/postgresql-9.4.1212.jre7.jar --driver=org.postgresql.Driver \
    --url=jdbc:postgresql://${DB_HOST}:${DB_PORT}/${DB_NAME} --username=${DB_USER} --password=${DB_PASS} \
    --changeLogFile=/opt/Project-Name-changelog.xml update
echo "[INFO]: Exiting with latest schema";

else
  echo -e "Please supply values to the blank parameters: \n"
  echo -e "Given value for DB_HOST is : $DB_HOST\n"
  echo -e "Given value for DB_NAME is : $DB_NAME\n"
  echo -e "Given value for DB_USER is : $DB_USER\n"
  echo -e "Given value for DB_PASS is : $DB_PASS\n"
fi

}
run_liquibase
