{ lib, config, pkgs, ... }:

{
  options = {
    custom.eduvpn.enable = lib.mkEnableOption "Enable EduVPN client";
  };

  config = lib.mkIf config.custom.eduvpn.enable {
    environment.systemPackages = with pkgs.stable; [
      eduvpn-client
    ];

    networking.wireguard.enable = true;

    networking.networkmanager.plugins = with pkgs.stable; [
      networkmanager-openvpn
    ];
  };
}
