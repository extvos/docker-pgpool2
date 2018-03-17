FROM extvos/alpine:3.7
MAINTAINER  "Mingcai SHEN <archsh@gmail.com>"

ENV PGPOOL_VERSION 3.7.0

RUN apk update \
    && apk add --no-cache pgpool \
    && mkdir -p /etc/pgpool2/

RUN wget https://github.com/noqcks/gucci/releases/download/v0.0.4/gucci-v0.0.4-linux-amd64 -O /usr/bin/gucci \
    && chmod +x /usr/bin/gucci \
    && mkdir -p /var/run/pgpool/ /etc/pgpool2/

ENV PCP_PORT 9898
ENV PCP_USERNAME postgres
ENV PCP_PASSWORD postgres
ENV PGPOOL_PORT 5432
ENV PGPOOL_BACKENDS postgres:5432:10
ENV TRUST_NETWORK 0.0.0.0/0
ENV PG_USERNAME postgres
ENV PG_PASSWORD postgres

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

CMD ["pgpool", "-n", "-f", "/etc/pgpool.conf", "-F", "/etc/pcp.conf", "-a", "/etc/pool_hba.conf"]


