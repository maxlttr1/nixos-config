{ lib, config, ... }:

{
  options = {
    systemd.enable = lib.mkEnableOption "Enable systemd config";
  };

  config = lib.mkIf config.systemd.enable {
    services.journald.extraConfig = ''
      SystemMaxFileSize=1G
    '';

    systemd.coredump.extraConfig = ''
      	  MaxUse=500M
      	'';
  };
}
