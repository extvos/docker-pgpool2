# docker-pgpool2
A Pgpool-II docker image base on alpine linux.

Environments will be used to fill the following template and generate the corresponding config files:

- /usr/share/pgpool2/pcp.conf.template
- /usr/share/pgpool2/pgpool.conf.template
- /usr/share//pgpool2/pool_hba.conf.template

## Usage
```bash
$ docker run -d --name pgpool \
         --env PGPOOL_BACKENDS=pg1:5432:5,pg2:5432:5,pg3:5432:5 \
         extvos/pgpool2
```

## Environment Ref:
```
ENV PCP_PORT 9898
ENV PCP_USERNAME postgres
ENV PCP_PASSWORD postgres
ENV PGPOOL_PORT 5432
ENV PGPOOL_BACKENDS postgres:5432:10
ENV TRUST_NETWORK 0.0.0.0/0

ENV NUM_INIT_CHILDREN 32
ENV MAX_POOL 4
ENV CHILD_LIFE_TIME 300
ENV CHILD_MAX_CONNECTIONS 0
ENV CONNECTION_LIFE_TIME 0
ENV CLIENT_IDLE_LIMIT 0
```