FROM ubuntu:bionic-20180526 AS add-apt-repositories

RUN apt-get update \
    && DEBIAN_FRONTEND=noninteractive apt-get install -y wget gnupg \
    && wget --quiet -O - http://1c.postgrespro.ru/keys/GPG-KEY-POSTGRESPRO-1C | apt-key add - \
    && echo 'deb http://1c.postgrespro.ru/archive/2018_09_03/deb bionic main' >> /etc/apt/sources.list

FROM ubuntu:bionic-20180526

LABEL maintainer="strizhhh@mail.ru" 
LABEL based="sameersbn/docker-postgresql"

ENV PG_APP_HOME="/etc/docker-postgresql" \
    PG_VERSION=9.6 \
    PG_USER=postgres \
    PG_HOME=/var/lib/postgresql \
    PG_RUNDIR=/run/postgresql \
    PG_LOGDIR=/var/log/postgresql \
    PG_CERTDIR=/etc/postgresql/certs

ENV PG_BINDIR=/usr/lib/postgresql/${PG_VERSION}/bin \
    PG_DATADIR=${PG_HOME}/${PG_VERSION}/main

COPY --from=add-apt-repositories /etc/apt/trusted.gpg /etc/apt/trusted.gpg
COPY --from=add-apt-repositories /etc/apt/sources.list /etc/apt/sources.list

RUN apt-get update \
    && apt-get install -y sudo locales wget  \
    && localedef -i ru_RU -c -f UTF-8 -A /usr/share/locale/locale.alias ru_RU.UTF-8 \
    && update-locale LANG=ru_RU.UTF-8 \
    && locale-gen en_US.UTF-8

ENV LANG ru_RU.UTF-8

RUN if dpkg -s libpq5 2>/dev/null; then apt-get remove -y libpq5; fi \
    && apt-get install -y libpq5=9.6.*.1C.bionic \
    && DEBIAN_FRONTEND=noninteractive apt-get install -y acl sudo \
        postgresql-pro-1c-${PG_VERSION} postgresql-client-${PG_VERSION} postgresql-contrib-${PG_VERSION} \
    && rm -rf ${PG_HOME} \
    && rm -rf /var/lib/apt/lists/*

COPY runtime/ ${PG_APP_HOME}/

COPY entrypoint.sh /sbin/entrypoint.sh

RUN chmod 755 /sbin/entrypoint.sh

EXPOSE 5432/tcp

WORKDIR ${PG_HOME}

ENTRYPOINT ["/sbin/entrypoint.sh"]
