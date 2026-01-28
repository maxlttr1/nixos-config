{ lib, config, ... }:

{
  options = {
    apparmor.enable = lib.mkEnableOption "Enable AppArmor security module";
  };

  config = lib.mkIf config.apparmor.enable {
    security.apparmor.enable = true;
  };
}

