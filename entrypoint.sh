#!/bin/sh

set -e

pgpool -ndD -f /etc/pgpool2/pgpool.conf -F /etc/pgpool2/pcp.conf