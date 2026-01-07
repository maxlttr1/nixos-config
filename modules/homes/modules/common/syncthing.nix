{
  services.syncthing = {
    enable = true;
    openDefaultPorts = true; # TCP/UDP 22000 for transfers and UDP 21027 for discovery.
    overrideDevices = true; # overrides any devices added or deleted through the WebUI
    overrideFolders = true; # overrides any folders added or deleted through the WebUI
    guiAddress = "0.0.0.0:8384";
  };
}
