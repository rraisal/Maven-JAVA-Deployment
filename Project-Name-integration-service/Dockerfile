FROM XXXXXXX/XXX/alpine-java-server-utc:8
MAINTAINER Raisal PA

ARG zookeeperConnection=zookeeper:2181
ARG microserviceid=integration-ms-node1
ARG microserviceprofile=production

ENV microserviceid=${microserviceid}
ENV zookeeperConnection=${zookeeperConnection}
ENV microserviceprofile=${microserviceprofile}
ENV APP_HOME=/u01
ENV LOG_HOME=/u01
ENV jarName=integration-ms.jar

COPY ${jarName} /u01/${jarName}
COPY startintegration.sh /usr/local/bin/
COPY templates /u01/templates
COPY logback.xml /u01/logback.xml

RUN apk add --no-cache bash tzdata openntpd && \
    adduser -D -u 1265 Project-Name && \
    mkdir -p ${APP_HOME} && mkdir -p ${LOG_HOME}/logs && \
    chown -R Project-Name: ${APP_HOME} && chown -R Project-Name: ${LOG_HOME} && \
    chown Project-Name: /usr/local/bin/startintegration.sh && chmod u+x /usr/local/bin/startintegration.sh

EXPOSE 8091
#USER Project-Name

WORKDIR $APP_HOME
ENTRYPOINT ["startintegration.sh"]
