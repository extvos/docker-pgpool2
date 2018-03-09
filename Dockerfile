FROM extvos/alpine
MAINTAINER  "Mingcai SHEN <archsh@gmail.com>"

ENV PGPOOL_VERSION 3.7.2

RUN apk update \
    && apk add build-base linux-headers postgresql-dev postgresql-libs \
    && wget http://www.pgpool.net/download.php?f=pgpool-II-${PGPOOL_VERSION}.tar.gz -O /tmp/pgpool-II-${PGPOOL_VERSION}.tar.gz \
    && cd /tmp \
    && tar zxf pgpool-II-${PGPOOL_VERSION}.tar.gz \
    && rm -f pgpool-II-${PGPOOL_VERSION}.tar.gz \
    && cd /tmp/pgpool-II-${PGPOOL_VERSION} \
    && ./configure --prefix=/usr \
                   --sysconfdir=/etc \
                   --with-openssl \
    && make \
    && make install \
    && cd .. && rm -rf pgpool-II-${PGPOOL_VERSION} \
    && apk del build-base linux-headers postgresql-dev

RUN wget https://github.com/noqcks/gucci/releases/download/v0.0.4/gucci-v0.0.4-linux-amd64 -O /usr/bin/gucci \
    && chmod +x /usr/bin/gucci

ENV PCP_PORT 9898
ENV PCP_USERNAME postgres
ENV PCP_PASSWORD postgres
ENV PGPOOL_PORT 5432
ENV PGPOOL_BACKENDS 1:postgres:5432
ENV TRUST_NETWORK 0.0.0.0/0

ENV NUM_INIT_CHILDREN 32
ENV MAX_POOL 4
ENV CHILD_LIFE_TIME 300
ENV CHILD_MAX_CONNECTIONS 0
ENV CONNECTION_LIFE_TIME 0
ENV CLIENT_IDLE_LIMIT 0

ADD config/pcp.conf.template /usr/share/pgpool2/pcp.conf.template
ADD config/pgpool.conf.template /usr/share/pgpool2/pgpool.conf.template
ADD config/pool_hba.conf.template /usr/share//pgpool2/pool_hba.conf.template
ADD entrypoint.sh /
RUN chmod +x /entrypoint.sh

EXPOSE 9898
EXPOSE 5432

ENTRYPOINT ["/bin/sh", "/entrypoint.sh"]

CMD ["pgpool", "-ndD", "-f /etc/pgpool2/pgpool.conf", "-F /etc/pgpool2/pcp.conf"]


