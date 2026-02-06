{ lib, config, pkgs, ... }:

{
  options = {
    i2p.enable = lib.mkEnableOption "Enable I2P router";
  };

  config = lib.mkIf config.i2p.enable {
    containers."i2pd-container" = {
      autoStart = true;
      config = { ... }: {
        system.stateVersion = "24.05";
        services.i2pd = {
          enable = true;
          address = "127.0.0.1";
          proto = {
            http.enable = true;
            httpProxy.enable = true;
            # socksProxy.enable = true; # Needed when wanting to use anything else than an HTTP connection
          };
        };

        networking.firewall.allowedTCPPorts = [
          7070 # default web interface port
          4444 # default http proxy port
          # 4447 # default socks proxy port
        ];
      };
    };
    
    programs.firefox = {
      enable = true;
      package = pkgs.librewolf;
      preferences = {
        "network.proxy.type" = 1;
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