#!/bin/sh
set -e

CONFIGDIR="/etc/ddclient"
CONFIGFILE="${CONFIGDIR}/ddclient.conf"

mkdir -p $CONFIGDIR
mkdir -p /var/cache/ddclient

if [[ -z "${DDNS_USERNAME}" ]]; then
    echo "DDNS_USERNAME must be set"
    exit 1
fi

if [[ -z "${DDNS_PASSWORD}" ]]; then
    echo "DDNS_PASSWORD must be set"
    exit 1
fi

if [[ -z "${DDNS_DOMAIN}" ]]; then
    echo "DDNS_DOMAIN must be set"
    exit 1
fi

cat > /etc/ddclient/ddclient.conf << EOL
daemon=300
syslog=yes
pid=/var/run/ddclient.pid
use=web, web=https://api.ipify.org
ssl=yes
protocol=googledomains
login=${DDNS_USERNAME}
password=${DDNS_PASSWORD}
${DDNS_DOMAIN}
EOL

chmod 600 /etc/ddclient/ddclient.conf

exec $@