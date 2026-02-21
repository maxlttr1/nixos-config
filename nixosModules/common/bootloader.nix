{ lib, config, ... }:

{
  options = {
    custom.bootloader.enable = lib.mkEnableOption "Enable systemd-boot bootloader configuration";
  };

  config = lib.mkIf config.custom.bootloader.enable {
    boot.loader.systemd-boot = {
      enable = true;
      configurationLimit = 10;
    };
    boot.loader.grub.enable = false;
  };
}
