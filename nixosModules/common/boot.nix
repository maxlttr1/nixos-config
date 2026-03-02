{ lib, config, pkgs, ... }:

{
  options = {
    custom.boot.enable = lib.mkEnableOption "Enable bootloader configuration";
  };

  config = lib.mkIf config.custom.boot.enable {
    /*
    boot.loader.systemd-boot = {
      enable = true;
      configurationLimit = 10;
    };
    boot.loader.grub.enable = false;
    */

    /*
    environment.systemPackages = with pkgs.stable; [
      sbctl
    ];
    */

    boot.loader.systemd-boot.enable = lib.mkForce false;

    boot.lanzaboote = {
      enable = true;
      pkiBundle = "/var/lib/sbctl";
      autoGenerateKeys.enable = true;
      autoEnrollKeys = {
        enable = true;
        autoReboot = true;
      };
    };
  };
}
