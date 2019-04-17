#!/bin/bash
set -e
Current_Dir=$PWD

prepare() {
echo "[INFO] --- Unzip core and integration zip files---"
cd $Current_Dir/target/core && unzip XXXXXXXXXXX-integration-ui-service-distribution.zip
cd $Current_Dir/target/integration && unzip integration-ms-distribution.zip

echo "[INFO] --- Copying WAR Files ---"
cp $Current_Dir/target/core/XXXXXXXXXXX-integration-ui-service/Project-Name-core-service.war $Current_Dir/Project-Name/Project-Name-core-service/
cp $Current_Dir/target/integration/integration-ms/integration-ms.jar $Current_Dir/Project-Name/Project-Name-integration-service/

echo "[INFO] --- Copying Database files ---"
mkdir $Current_Dir/Project-Name/Project-Name-pgsql-loaddata/liquibase
wget http://docker-images.XXXXXXXXXXX/binaries/liquibase.jar -O $Current_Dir/Project-Name/Project-Name-pgsql-loaddata/liquibase/liquibase.jar
wget http://docker-images.XXXXXXXXXXX/binaries/postgresql-9.4.1212.jre7.jar -O $Current_Dir/Project-Name/Project-Name-pgsql-loaddata/liquibase/postgresql-9.4.1212.jre7.jar
cp -r $Current_Dir/target/db/distribution/ $Current_Dir/Project-Name/Project-Name-pgsql-loaddata/liquibase/

echo "[INFO] --- Copying Zookeeper Files ---"
wget http://docker-images.XXXXXXXXXXX/binaries/zookeeper-3.4.12.tar.gz -O $Current_Dir/target/zookeeper-3.4.12.tar.gz
cd $Current_Dir/target && tar -xvf zookeeper-3.4.12.tar.gz -C $Current_Dir/Project-Name/Project-Name-zookeeper/
wget http://docker-images.XXXXXXXXXXX/binaries/zkui-2.0.jar -O $Current_Dir/Project-Name/Project-Name-zookeeper/zkui/zkui-2.0.jar
cd $Current_Dir/target/core/XXXXXXXXXXX-integration-ui-service/configuration && unzip Project-Name-configuration-distribution.zip
cp $Current_Dir/target/core/XXXXXXXXXXX-integration-ui-service/configuration/Project-Name-core.cfg $Current_Dir/Project-Name/Project-Name-zookeeper/

cd $Current_Dir/target/integration/integration-ms/configuration && unzip integration-ms-configuration-production.zip
cp $Current_Dir/target/integration/integration-ms/configuration/integration-ms.cfg $Current_Dir/Project-Name/Project-Name-zookeeper/
cp -r $Current_Dir/target/integration/integration-ms/configuration/templates $Current_Dir/Project-Name/Project-Name-integration-service

echo "[INFO] --- Copying Logback file ---"
cp $Current_Dir/target/core/XXXXXXXXXXX-integration-ui-service/configuration/logback.xml $Current_Dir/Project-Name/Project-Name-core-service/
cp $Current_Dir/target/core/XXXXXXXXXXX-integration-ui-service/configuration/logback.xml $Current_Dir/Project-Name/Project-Name-integration-service/

echo "[INFO] --- Copying Web files ---"
mkdir $Current_Dir/Project-Name/Project-Name-nginx/web
unzip $Current_Dir/target/web/Project-Name-ui-web.zip -d $Current_Dir/Project-Name/Project-Name-nginx/web

echo "[INFO] --- Copying java-openjfx Files ---"
wget http://docker-images.XXXXXXXXXXX/binaries/java-openjfx-8.151.12.tar.gz -O $Current_Dir/target/java-openjfx-8.151.12.tar.gz
cd $Current_Dir/target && tar -xvf java-openjfx-8.151.12.tar.gz -C $Current_Dir/Project-Name/Project-Name-core-service/

}
prepare
