{
  lib,
  config,
  pkgs,
  settings,
  ...
}:

{
  options = {
    custom.arduino.enable = lib.mkEnableOption "Enable Arduino development environment";
  };

  config = lib.mkIf config.custom.arduino.enable {
    environment.systemPackages = with pkgs; [
      arduino-ide
    ];

    users.users.${settings.username}.extraGroups = [ "dialout" ];
  };
}
