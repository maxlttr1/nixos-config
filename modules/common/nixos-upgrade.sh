#!/bin/bash

set -e
LOGFILE=/var/log/nixos-upgrade.log
HOSTNAME=$(cat /etc/hostname)
DISCORD_WEBHOOK_URL=$(cat /etc/discord-webhook.conf)

echo "[$(date)] Starting upgrade..." >> $LOGFILE

if ${pkgs.nixos-rebuild}/bin/nixos-rebuild switch --flake github:maxlttr1/nixos-config >> $LOGFILE 2>&1; then
    echo "[$(date)] ✅ Upgrade succeeded." >> $LOGFILE

    ${pkgs.curl}/bin/curl -X POST $DISCORD_WEBHOOK_URL \
    -H "Content-Type: application/json" \
    -d "{\"content\": \"✅ NixOS upgrade success on $HOSTNAME\"}"
else
    echo "[$(date)] ❌ Upgrade FAILED!" >> $LOGFILE

    ${pkgs.curl}/bin/curl -X POST $DISCORD_WEBHOOK_URL \
    -H "Content-Type: application/json" \
    -d "{\"content\": \"❌ NixOS upgrade failed on $HOSTNAME. Check the logs for details.\"}"
fi