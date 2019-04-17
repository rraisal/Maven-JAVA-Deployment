#!/bin/bash

zookeeper_server(){
  echo "[INFO]: Zookeeper Server Staring ...";
  $ZOOKEEPER_HOME/bin/zkServer.sh start
  echo "[INFO]: Zookeeper UI Starting ...";
  cd $ZKUI_DIR && (nohup java -Dzkui -jar zkui-2.0.jar > /dev/null 2>&1 &)

  load_properties

  tail -f $ZKUI_DIR/zookeeper.out
}

load_properties(){

    while ! nc -z localhost 9090; do sleep 3; done
    echo "[INFO]: Zookeeper Port Available";
    curl -c cookies.txt -b cookies.txt -d "username=admin&password=XXXXX" http://localhost:9090/login
    curl -c cookies.txt -b cookies.txt -v -F scmFile=@/opt/Project-Name-core.cfg scmServer=http://myserver.com/@rev1= http://localhost:9090/import
    curl -c cookies.txt -b cookies.txt -d "username=admin&password=XXXXXX" http://localhost:9090/login
    curl -c cookies.txt -b cookies.txt -v -F scmFile=@/opt/integration-ms.cfg scmServer=http://myserver.com/@rev1= http://localhost:9090/import

    echo "[INFO]: Configuration files uploaded";
}

zookeeper_server
