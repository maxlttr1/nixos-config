{ config, pkgs, ... }:

{
  # Enable containers
  virtualisation.containers.enable = true;  
  virtualisation = {
    podman = {
      enable = true;
      defaultNetwork.settings.dns_enabled = true; 
    };
  };
}
