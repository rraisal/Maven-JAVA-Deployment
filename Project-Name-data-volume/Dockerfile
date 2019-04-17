FROM alpine:3.6

MAINTAINER Raisal PA 

COPY startup.sh /opt/

RUN apk add --no-cache bash && \
    adduser -D -u 1265 ttmp && \
    chmod u+x /opt/startup.sh

VOLUME /mnt

ENTRYPOINT ["/bin/sh", "/opt/startup.sh"]
