{ config, pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    eduvpn-client
  ];

  networking.wireguard.enable = true;

  networking.networkmanager.enable = true;
  networking.networkmanager.plugins = with pkgs; [
    networkmanager-openvpn
  ];
  
  services.resolved = {
    enable = true;
    fallbackDns = [ "9.9.9.9"];
  };
}