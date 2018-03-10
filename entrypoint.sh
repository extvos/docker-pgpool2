#!/bin/sh

set -e

export PCP_PASSWORD_MD5=`pg_md5 ${PCP_PASSWORD}`

/usr/bin/gucci /usr/share/pgpool2/pcp.conf.template > /etc/pgpool2/pcp.conf
/usr/bin/gucci /usr/share/pgpool2/pgpool.conf.template > /etc/pgpool2/pgpool.conf
/usr/bin/gucci /usr/share/pgpool2/pool_hba.conf.template > /etc/pgpool2/pool_hba.conf

# if [ "$1" = 'pgpool-server' ]; then
# 	exec pgpool "$@"
# fi

exec "$@"

