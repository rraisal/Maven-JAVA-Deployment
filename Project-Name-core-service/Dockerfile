FROM openjdk:8-jre-alpine

MAINTAINER Raisal PA
ARG microserviceid=XXXXXX-core-node1
ARG microserviceprofile=XXXX

ENV microserviceid=${microserviceid}
ENV zookeeperConnection=${zookeeperConnection}
ENV microserviceprofile=${microserviceprofile}
ENV APP_HOME=/u01
ENV LOG_HOME=/u01
ENV jarName=XXXXXX-core-service.war

COPY ${jarName} /u01/${jarName}
COPY logback.xml /u01/logback.xml
COPY startcore.sh /usr/local/bin/
COPY java-openjfx-8.151.12/java-openjfx-8.151.12-r0.apk ${APP_HOME}

RUN apk add --no-cache bash && \
    adduser -D -u 1265 XXXXXX && \
    mkdir -p ${APP_HOME} && mkdir -p ${LOG_HOME}/logs && \
    chown -R XXXXXX: ${APP_HOME} && chown -R XXXXXX: ${LOG_HOME} && \
    chown XXXXXX: /usr/local/bin/startcore.sh && chmod u+x /usr/local/bin/startcore.sh &&\
    cd ${APP_HOME} && apk --allow-untrusted add --no-cache java-openjfx-8.151.12-r0.apk

EXPOSE 7088
#USER XXXXXX
WORKDIR $APP_HOME

ENTRYPOINT ["startcore.sh"]
