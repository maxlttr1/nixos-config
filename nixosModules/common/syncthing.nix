{ lib, config, ... }:

{
  options = {
    syncthing.enable = lib.mkEnableOption "Enable Syncthing file synchronization";
  };

  config = lib.mkIf config.syncthing.enable {
    services.syncthing = {
      enable = true;
      openDefaultPorts = true; # TCP/UDP 22000 for transfers and UDP 21027 for discovery.
      overrideDevices = true; # overrides any devices added or deleted through the WebUI
      overrideFolders = true; # overrides any folders added or deleted through the WebUI
      user = "${config.users.mainUsername}";
      group = "syncthing";
      dataDir = "/home/${config.users.mainUsername}/.syncthing"; # Custom data directory for Syncthing
      configDir = "/home/${config.users.mainUsername}/.config/syncthing"; # Custom config directory
      guiAddress = "0.0.0.0:8384";
    };

    networking.firewall.allowedTCPPorts = [ 8384 ];

    users.users."${config.users.mainUsername}".extraGroups = [ "syncthing" ];
  };
}
