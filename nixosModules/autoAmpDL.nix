{ lib, config, pkgs, settings, ... }:

let
  script = pkgs.writeShellScript "script" ''
    if [ ! -d "AutoAmpDL" ]; then
      ${pkgs.git}/bin/git clone https://github.com/maxlttr1/AutoAmpDL.git
    fi
    cd AutoAmpDL/

    nix develop .
    python src/main.py --url ${config.custom.autoAmpDL.url} --download-archive ${config.custom.autoAmpDL.downloadArchiveFile} --cookies ${config.custom.autoAmpDL.cookieFile} ${config.custom.autoAmpDL.targetDir}
  '';
in

{
  options = {
    custom.autoAmpDL.enable = lib.mkEnableOption "Enable automatic AmpDL updates";
    custom.autoAmpDL.frequency = lib.mkOption {
      description = "AutoAmpDL frequency";
      default = "weekly";
      type = lib.types.enum [ "daily" "weekly" "monthly" "yearly" ];
    };
    custom.autoAmpDL.url = lib.mkOption {
      description = "URL to download from";
      default = "https://www.youtube.com/watch?v=iSC4P1i9zmE&list=PLkF8ZEu4FB1kvxIhG9jLAEauSivb5JJGD&pp=sAgC";
      type = lib.types.str;
    };
    custom.autoAmpDL.targetDir = lib.mkOption {
      description = "Directory where files will be downloaded";
      default = "/home/${settings.username}/Syncthing/music/AutoAmpDL/";
      type = lib.types.str;
    };
    custom.autoAmpDL.workingDir = lib.mkOption {
      description = "Directory where project files will be downloaded";
      default = "/home/${settings.username}/Documents/";
      type = lib.types.str;
    };
    custom.autoAmpDL.cookieFile = lib.mkOption {
      description = "Path to the cookie file for authentication";
      default = "/home/${settings.username}/Syncthing/music/cookies.firefox-private.txt";
      type = lib.types.str;
    };
    custom.autoAmpDL.downloadArchiveFile = lib.mkOption {
      description = "Path to the download archive file to avoid re-downloading files";
      default = "/home/${settings.username}/Syncthing/music/ids.txt";
      type = lib.types.str;
    };
  };

  config = lib.mkIf config.custom.autoAmpDL.enable {
    systemd.services."auto-amp-dl" = {
      description = "Start AutAmpDL script on a schedule";
      timerConfig = {
        serviceConfig = {
          WorkingDirectory = "${config.custom.autoAmpDL.workingDir}";
          User = "${settings.username}";
          Type = "oneshot";
          ExecStart = "${script}";
        };
      };
    };
    
    timers."auto-amp-dl" = {
      wantedBy = ["multi-user.target"];
      timerConfig = {
        OnCalendar = "${config.custom.autoAmpDL.frequency}";
        Unit = "auto-amp-dl";
      };
    };
  };
}