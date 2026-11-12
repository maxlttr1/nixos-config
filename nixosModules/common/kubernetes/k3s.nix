{
  lib,
  config,
  pkgs,
  ...
}:

{
  options = {
    custom.k3s.enable = lib.mkEnableOption "Enable automatic k3s management";
  };

  config = lib.mkIf config.custom.k3s.enable {
    services.k3s = {
      enable = true;
      role = "server";
      extraFlags = toString [
        # "--debug" # Optionally add additional args to k3s
      ];
    };

    

    environment.systemPackages = with pkgs; [
      kubectl
      k9s
      helm
    ];

    networking.firewall.allowedTCPPorts = [
      # 6443 # k3s: required so that pods can reach the API server (running on port 6443 by default)
      # 2379 # k3s, etcd clients: required if using a "High Availability Embedded etcd" configuration
      # 2380 # k3s, etcd peers: required if using a "High Availability Embedded etcd" configuration
    ];
    networking.firewall.allowedUDPPorts = [
      # 8472 # k3s, flannel: required if using multi-node for inter-node networking
    ];

  };
}
