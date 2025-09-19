{ pkgs, ... }:

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
      ExecStart = ''
        url="$(${pkgs.coreutils}/bin/cat /etc/discord-webhook.conf)"

        ${pkgs.curl}/bin/curl -X POST "https://discord.com/api/" \
          -H "Content-Type: application/json" \
          -d "{\"content\": \" $url: 📣\"}"
      '';
    };
  };
}