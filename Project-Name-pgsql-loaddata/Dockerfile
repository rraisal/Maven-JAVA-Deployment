FROM openjdk:8-jre-alpine

MAINTAINER Raisal PA

ADD liquibase/distribution/*.xml /opt/
ADD liquibase/*.jar /opt/

COPY pgdataload.sh /usr/local/bin/

RUN apk add --no-cache bash && \
    chmod u+x /usr/local/bin/pgdataload.sh
    
ENTRYPOINT ["pgdataload.sh"]
