#!/bin/bash
set -e

# ---------------------------------------
# User map based on PUID/PGID
# ---------------------------------------
if [ "$(id -u)" = '0' ]; then
    # fix ownership
    chown -R 0:0 /var/lib/tor 2>/dev/null || true
    chown -R 0:0 /etc/tor 2>/dev/null || true
fi

# ---------------------------------------
# update torrc config from templates
# ---------------------------------------
for relaytype in bridge middle exit; do
    file="/etc/tor/torrc.${relaytype}"
    if [ -f "$file" ]; then
        sed -i "s/RELAY_NICKNAME/${RELAY_NICKNAME}/g" "$file"
        sed -i "s/CONTACT_GPG_FINGERPRINT/${CONTACT_GPG_FINGERPRINT}/g" "$file"
	    sed -i "s/CONTACT_NAME/${CONTACT_NAME}/g" "$file"
        sed -i "s/CONTACT_EMAIL/${CONTACT_EMAIL}/g" "$file"
        sed -i "s/RELAY_BANDWIDTH_RATE/${RELAY_BANDWIDTH_RATE}/g" "$file"
        sed -i "s/RELAY_BANDWIDTH_BURST/${RELAY_BANDWIDTH_BURST}/g" "$file"
        sed -i "s/RELAY_ORPORT/${RELAY_ORPORT}/g" "$file"
        sed -i "s/RELAY_DIRPORT/${RELAY_DIRPORT}/g" "$file"
        sed -i "s/RELAY_CTRLPORT/${RELAY_CTRLPORT}/g" "$file"
        sed -i "s/RELAY_ACCOUNTING_MAX/${RELAY_ACCOUNTING_MAX}/g" "$file"
        sed -i "s/RELAY_ACCOUNTING_START/${RELAY_ACCOUNTING_START}/g" "$file"
    fi
done

echo "Starting Tor as root (UID=0) which is mapped to host user"

exec tor -f "/etc/tor/torrc.${RELAY_TYPE}" --User root --DataDirectory /var/lib/tor
