#!/bin/sh

set -e
/usr/bin/gucci /usr/share/pgpool2/pcp.conf.template > /etc/pgpool2/pcp.conf
/usr/bin/gucci /usr/share/pgpool2/pgpool.conf.template > /etc/pgpool2/pgpool.conf
/usr/bin/gucci /usr/share/pgpool2/pool_hba.conf.template > /etc/pgpool2/pool_hba.conf
pgpool -ndD -f /etc/pgpool2/pgpool.conf -F /etc/pgpool2/pcp.conf