{ pkgs, ... }:

{
  services.xserver.enable = true;
  services.desktopManager.plasma6.enable = true;
  services.displayManager.sddm.enable = true;
  services.displayManager.sddm.autoNumlock = true;
  services.displayManager.sddm.wayland.enable = false;
  services.displayManager.defaultSession = "plasmax11";

  /*qt = {
    enable = true;
    platformTheme = "gnome";
    style = "adwaita-dark";
  };*/

  environment.systemPackages = 
    (with pkgs; [
      libsForQt5.qt5.qtquickcontrols2
      libsForQt5.qt5.qtgraphicaleffects
    ])
    ++
    (with pkgs.unstable; [
    ]);

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
    konsole
    #krdp
    oxygen
    plasma-browser-integration
  ];
}
