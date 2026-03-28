{ config, lib, pkgs, ... }:

{
  options.custom.i2p-browser.enable = lib.mkEnableOption "Enable i2p librewolf browser and desktop entry";

  config = lib.mkIf config.custom.i2p-browser.enable {
    xdg.desktopEntries = {
      i2p-browser = {
        name = "i2p Browser";
        genericName = "Web Browser";
        exec = "${pkgs.librewolf}/bin/librewolf";
        icon = "librewolf";
      };
    };

    programs.firefox = {
      enable = true;
      package = pkgs.librewolf;
      profiles.default.settings = {
        "network.proxy.http" = "127.0.0.1";
        "network.proxy.http_port" = 4444;
        # "network.proxy.socks" = "127.0.0.1";
        # "network.proxy.socks_port" = 4447;
        "keyword.enabled" = false; # Don't search .i2p domains
        "dom.security.https_only_mode" = false; # i2p doesn't use HTTPS
      };
    };
  };
}
