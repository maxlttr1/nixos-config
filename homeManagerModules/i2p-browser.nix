{ config, lib, ... }:

{
  options.custom.i2p-browser.enable = lib.mkEnableOption "Enable i2p librewolf browser and desktop entry";

  config = lib.mkIf config.custom.i2p-browser.enable {
    xdg.desktopEntries = {
      i2p-browser = {
        name = "i2p Browser";
        genericName = "Web Browser";
        exec = "librewolf -P default";
        icon = "librewolf";
      };
    };

    programs.librewolf = {
      enable = true;
      policies = {
        NoDefaultBookmarks = false;
      };
      profiles.default = {
        settings = {
          "network.proxy.type" = 1; # 1 = Manual proxy configuration, 5 = Use system proxy
          "network.proxy.http" = "100.68.245.10";
          "network.proxy.http_port" = 4444;
          "network.proxy.no_proxies_on" = "100.68.245.10/24,nexus-nexus,";
          # "network.proxy.socks" = "127.0.0.1";
          # "network.proxy.socks_port" = 4447;
          "keyword.enabled" = false; # Don't search .i2p domains
          "dom.security.https_only_mode" = false; # i2p doesn't use HTTPS
        };
        bookmarks = {
          force = true;
          settings = [
            {
              name = "i2p";
              toolbar = true;
              bookmarks = [
                {
                  name = "router console";
                  url = "http://100.68.245.10:7657/";
                }
                {
                  name = "planet.i2p";
                  url = "http://planet.i2p/";
                }
                {
                  name = "postman.i2p";
                  url = "http://tracker2.postman.i2p";
                }
              ];
            }
          ];
        };
      };
    };
  };
}
