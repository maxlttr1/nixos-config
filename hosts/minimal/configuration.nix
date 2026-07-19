{ lib, ... }:

{
  custom.hostname = "minimal";

  custom.boot.enable = lib.mkForce false;
  custom.clamav.enable = lib.mkForce false;
  # custom.flatpak.enable = true;
  custom.networkManager.enable = lib.mkForce true;
  custom.ssh.enable = true;
}
