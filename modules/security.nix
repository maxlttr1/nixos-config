{ config, pkgs, ... }:

{
  security.apparmor.enable = true;

  security.sudo.wheelNeedsPassword = true;
  security.sudo.execWheelOnly = true;

  # Restrict access to nix daemon
  nix.settings.allowed-users = [ "@wheel" ];
}
