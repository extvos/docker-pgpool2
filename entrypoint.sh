#!/bin/sh

set -e

export PCP_PASSWORD_MD5=`pg_md5 ${PCP_PASSWORD}`

# To configure pgpool2
/usr/bin/gucci /usr/share/pgpool2/pcp.conf.template > /etc/pgpool2/pcp.conf
/usr/bin/gucci /usr/share/pgpool2/pgpool.conf.template > /etc/pgpool2/pgpool.conf
/usr/bin/gucci /usr/share/pgpool2/pool_hba.conf.template > /etc/pgpool2/pool_hba.conf

# To be able to use "pcp_*" in scripts without prompting for a password
/usr/bin/gucci /usr/share/pgpool2/pcppass.template > /root/.pcppass
chmod 0600 /root/.pcppass

# Create autohealing script to rebuild pgpool2
/usr/bin/gucci /usr/share/pgpool2/autohealing.sh.template > /usr/bin/autohealing
chmod +x /usr/bin/autohealing

/usr/bin/pg_md5 -m -f /etc/pgpool2/pgpool.conf -u ${PG_USERNAME} ${PG_PASSWORD}
# if [ "$1" = 'pgpool-server' ]; then
# 	exec pgpool "$@"
# fi

exec "$@"

