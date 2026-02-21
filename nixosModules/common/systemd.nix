{ lib, config, ... }:

{
  options = {
    custom.systemd.enable = lib.mkEnableOption "Enable systemd config";
  };

  config = lib.mkIf config.custom.systemd.enable {
    services.journald.extraConfig = ''
      SystemMaxFileSize=500M
      SystemMaxFiles=5
    '';

    systemd.coredump.extraConfig = ''
      MaxUse=500M
    '';
  };
}
