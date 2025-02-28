{ settings, ... }:

{
  services.syncthing = {
    enable = true;
    openDefaultPorts = true; # TCP/UDP 22000 for transfers and UDP 21027 for discovery.
    overrideDevices = true;     # overrides any devices added or deleted through the WebUI
    overrideFolders = true;     # overrides any folders added or deleted through the WebUI
    user = "${settings.username}";
    group = "syncthing";
    dataDir = "/home/${settings.username}/.syncthing";   # Custom data directory for Syncthing
    configDir = "/home/${settings.username}/.config/syncthing";  # Custom config directory
  };
  networking.firewall.allowedTCPPorts = [ 8384 ];
}