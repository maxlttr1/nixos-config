{ pkgs, ... }:

{
  systemd.timers."nixos-upgrade" = {
    wantedBy = [ "timers.target" ]; # Ensures the timer starts on boot
    timerConfig = {
      OnCalendar = "daily";
      Persistent = true; # If the system was off during the scheduled time, run it as soon as possible after boot
    };
  };

  systemd.services."nixos-upgrade" = {
    after = [ "network-online.target" ];
    requires = [ "network-online.target" ];
    environment = "PATH=${pkgs.nixos-rebuild}/bin:${pkgs.stdenv.cc.cc}/bin:${pkgs.stdenv.shell}/bin";
    serviceConfig = {
      Type = "oneshot";
      User = "root";
    };
    script = ''
      set -e
      LOGFILE=/var/log/nixos-upgrade.log
      DISCORD_WEBHOOK_URL=$(cat /etc/discord-webhook.conf)

      echo "[$(date)] Starting upgrade..." >> $LOGFILE

      if nixos-rebuild switch --flake github:maxlttr1/nixos-config#$(hostname) >> $LOGFILE 2>&1; then
        echo "[$(date)] ✅ Upgrade succeeded." >> $LOGFILE
      else
        echo "[$(date)] ❌ Upgrade FAILED!" >> $LOGFILE
        
        # Send failure message to Discord
        curl -X POST $DISCORD_WEBHOOK_URL \
          -H "Content-Type: application/json" \
          -d '{"content": "NixOS upgrade failed on host '"$(hostname)"'. Check the logs for details."}'
      fi
    '';
  };
}