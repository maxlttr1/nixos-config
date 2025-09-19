{ pkgs, ... }:
let
  notifyScript = pkgs.writeShellScript "notify-discord" ''
    
    url=$(cat /etc/discord-webhook.conf)
    hostname=$(${pkgs.nettools}/bin/hostname)
    status=$(systemctl show nixos-upgrade.service -p ExecMainStatus --value)

    if [ $status -eq 0 ]; then
      ${pkgs.curl}/bin/curl -X POST "$url" \
        -H "Content-Type: application/json" \
        -d "{\"content\": \"✅ NixOS upgrade successful on **$hostname**\"}"
    else
      ${pkgs.curl}/bin/curl -X POST "$url" \
        -H "Content-Type: application/json" \
        -d "{\"content\": \"❌ NixOS upgrade failed on **$hostname**\"}"
    fi
  ''; 
in
{
  system.autoUpgrade = {
    # Check for generations: sudo nix-env -p /nix/var/nix/profiles/system --list-generations
    enable = true;
    flake = "github:maxlttr1/nixos-config";
    flags = [
      #"--update-input"
      #"nixpkgs-main"
      "-L" # Show logs
    ];
    dates = "Sun 02:00";  # Every Sunday at 2 AM
    randomizedDelaySec = "30min";
    persistent = true;
    operation = "switch"; # Or "boot"
    allowReboot = true;
    rebootWindow = {
      lower = "01:00";
      upper = "05:00";
    };
  };

  systemd.services."nixos-upgrade-notification" = {
    description = "Service to send a notificarions when the nixos-upgrade ends";
    wantedBy = ["nixos-upgrade.service"];
    #after = ["nixos-upgrade.service"];
    serviceConfig = {
      ExecStart = "${notifyScript}";
    };
  };
}