FROM openjdk:8-jre-alpine
MAINTAINER Raisal PA

ENV VERSION=3.4.12
ENV ZOOKEEPER_HOME=/opt/zookeeper-${VERSION}
ENV ZKUI_DIR=/opt/zkui

ADD zkui/ /opt/zkui
ADD zookeeper-${VERSION} ${ZOOKEEPER_HOME}

COPY zoo.cfg /opt/zookeeper-${VERSION}/conf/
COPY startzookeeper.sh /usr/local/bin/
COPY integration-ms.cfg /opt
COPY Project-Name-core.cfg /opt


RUN apk add --no-cache curl bash && \
     adduser -D -u 1234 zkeeper && \
     chown -R zkeeper: /opt && chown zkeeper: /usr/local/bin/startzookeeper.sh && chmod u+x /usr/local/bin/startzookeeper.sh

EXPOSE 2181 2888 3888 9090

USER zkeeper

WORKDIR $ZKUI_DIR

ENTRYPOINT ["startzookeeper.sh"]
