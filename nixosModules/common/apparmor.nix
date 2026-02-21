{ lib, config, ... }:

{
  options = {
    custom.apparmor.enable = lib.mkEnableOption "Enable AppArmor security module";
  };

  config = lib.mkIf config.custom.apparmor.enable {
    security.apparmor.enable = true;
  };
}

