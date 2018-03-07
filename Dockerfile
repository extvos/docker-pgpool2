FROM extvos/alpine
MAINTAINER  "Mingcai SHEN <archsh@gmail.com>"

ENV PGPOOL_VERSION 3.7.2

RUN apk update \
    && apk add build-base linux-headers postgresql-dev \
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