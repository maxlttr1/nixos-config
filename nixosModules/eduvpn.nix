{ lib, config, pkgs, ... }:

{
  options = {
    eduvpn.enable = lib.mkEnableOption "Enable EduVPN client";
  };

  config = lib.mkIf config.eduvpn.enable {
    environment.systemPackages = with pkgs.stable; [
      eduvpn-client
    ];

    networking.wireguard.enable = true;

    networking.networkmanager.plugins = with pkgs.stable; [
      networkmanager-openvpn
    ];
  };
}
