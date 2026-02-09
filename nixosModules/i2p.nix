{ lib, config, pkgs, settings, ... }:

{
  options = {
    i2p.enable = lib.mkEnableOption "Enable I2P router";
  };

  config = lib.mkIf config.i2p.enable {
    /*containers."i2pd-container" = {
      autoStart = true;
      bindMounts."/var/lib/i2pd" = {
        hostPath = "/var/lib/i2pd";
        isReadOnly = false;
      };
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
    };*/

    virtualisation.oci-containers = {
      backend = "docker";
      containers = {
        i2p = {
          image = "geti2p/i2p:latest";
          autoStart = true;
          ports = [
            "127.0.0.1:7657:7657" # Router console
            "127.0.0.1:4444:4444" # HTTP proxy
            "127.0.0.1:4447:4447" # SOCKS proxy
            "0.0.0.0:6668:6668" # IRC proxy
            "54323:12345" # I2NP Protocol
            "54323:12345/udp" # I2NP Protocol
          ];
          volumes = [
            "/home/${settings.username}/docker/i2p/i2phome:/i2p/.i2p"
            "/home/${settings.username}/docker/i2p/i2ptorrents:/i2p/i2psnark"
          ];
          environment = {
            EXT_PORT = "12345";
          };
        };
      };
    };

    programs.firefox = {
      enable = true;
      package = pkgs.librewolf;
      preferences = {
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
