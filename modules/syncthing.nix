{ settings, ... }:

{
  services.syncthing = {
    enable = true;
    openDefaultPorts = true;
    overrideDevices = true;     # overrides any devices added or deleted through the WebUI
    overrideFolders = true;     # overrides any folders added or deleted through the WebUI
    user = "${settings.username}";
  };
}