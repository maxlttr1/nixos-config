{ pkgs, ... }:

{
  services.xserver.enable = true;
  services.desktopManager.plasma6.enable = true;
  services.displayManager.sddm = {
    enable = true;
    theme = "${import ../packages/sddm-theme.nix { inherit pkgs; }}";
  };

  programs.kdeconnect.enable = true;

  # Open ports in the firewall for kde connect
  networking.firewall = rec {
    allowedTCPPortRanges = [ { from = 1714; to = 1764; } ];
    allowedUDPPortRanges = allowedTCPPortRanges;
  };

  environment.plasma6.excludePackages = with pkgs.kdePackages; [
    discover
    elisa
    kate
    khelpcenter
    #krdp
    oxygen
    plasma-browser-integration
  ];
}
