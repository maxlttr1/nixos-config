{ config, pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    eduvpn-client
  ];

  networking.wireguard.enable = true;

  networking.networkmanager.plugins = with pkgs; [
    networkmanager-openvpn
  ];
}
