{ lib, config, ... }:

{
  options = {
    systemd.enable = lib.mkEnableOption "Enable systemd config";
  };

  config = lib.mkIf config.systemd.enable {
    services.journald.extraConfig = ''
      SystemMaxFileSize=500M
      SystemMaxFiles=5
    '';

    systemd.coredump.extraConfig = ''
      MaxUse=500M
    '';
  };
}
