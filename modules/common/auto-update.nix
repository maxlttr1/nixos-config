{ pkgs, ... }:

let
  script = ''
    set -e
    LOGFILE=/var/log/nixos-upgrade.log
    HOSTNAME=$(cat /etc/hostname)
    DISCORD_WEBHOOK_URL=$(cat /etc/discord-webhook.conf)

    echo "[$(date)] Starting upgrade..." >> $LOGFILE

    if ${pkgs.nixos-rebuild}/bin/nixos-rebuild switch --flake github:maxlttr1/nixos-config#$HOSTNAME >> $LOGFILE 2>&1; then
      echo "[$(date)] ✅ Upgrade succeeded." >> $LOGFILE

      ${pkgs.curl}/bin/curl -X POST $DISCORD_WEBHOOK_URL \
        -H "Content-Type: application/json" \
        -d "{\"content\": \"NixOS upgrade success on $HOSTNAME ✅\"}"
    else
      echo "[$(date)] ❌ Upgrade FAILED!" >> $LOGFILE

      ${pkgs.curl}/bin/curl -X POST $DISCORD_WEBHOOK_URL \
        -H "Content-Type: application/json" \
        -d "{\"content\": \"NixOS upgrade failed on $HOSTNAME ❌. Check the logs for details.\"}"
    fi
  '';
in

{
  systemd.timers."nixos-upgrade" = {
    wantedBy = [ "timers.target" ]; # Ensures the timer starts on boot
    timerConfig = {
      OnCalendar = "daily";
      Persistent = true; # If the system was off during the scheduled time, run it as soon as possible after boot
    };
  };

  systemd.services."nixos-upgrade" = {
    #wantedBy = [ "multi-user.target" ]; # Start this service automatically when the system is ready for users
    after = [ "network-online.target" "nss-lookup.target" ];
    requires = [ "network-online.target" "nss-lookup.target" ];
    /*path = with pkgs; [ 
      curl 
      nixos-rebuild 
      coreutils 
    ];*/
    serviceConfig = {
      Type = "oneshot";
      User = "root";
      #ExecStart = "${script}";
    };
    inherit script;
  };
}