#!/bin/bash

wait_for_dependency_service(){

  sleep 3s;
  ntpd -s
  echo "Time synched"

  sleep 7s;
  echo "[INFO]: Cheking Dependencies";
  while ! nc -z zookeeper 9090; do sleep 3; done
  while ! nc -z zookeeper 2181; do sleep 3; done
  echo "[INFO]: Zookeeper Port Available";
  while ! nc -z postgres 5432; do sleep 3; done
  echo "[INFO]: PostgreSQL Port Available";
}

start_integration(){
        wait_for_dependency_service
        java -server -Xmx2048m -Xms256m \
        -Dmicro-service.profile=$microserviceprofile \
        -Dodin.zookeeper.connectString=$zookeeperConnection \
        -Dmicro-service.id=$microserviceid \
        -Dlogging.config=$APP_HOME/logback.xml -jar $APP_HOME/$jarName
}

start_integration
