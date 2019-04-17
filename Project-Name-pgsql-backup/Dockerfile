FROM alpine:3.6

ENV POSTGRES_PASSWORD=XXXX
ENV POSTGRES_USER=XXXX
ENV POSTGRES_DB=XXXX

COPY ./aws /root/.aws
COPY pg-backup.sh /usr/local/bin/pg-backup.sh
COPY .pgpass /root/.pgpass

RUN apk -v --update add \
        bash \
        python \
        py-pip \
        groff \
        less \
        mailcap \
        curl \
        libpq \
        postgresql-client \
        postgresql \
        postgresql-contrib\
        && \
    pip install --upgrade awscli==1.14.5 s3cmd==2.0.1 python-magic && \
    apk -v --purge del py-pip && \
    rm /var/cache/apk/* && chmod u+x /usr/local/bin/pg-backup.sh && \
    chmod 0600 /root/.pgpass

ENTRYPOINT ["pg-backup.sh"]
