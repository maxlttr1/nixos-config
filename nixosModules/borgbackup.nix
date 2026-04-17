{ lib, config, pkgs, settings, ... }:

{
  options = {
    custom.borgbackup.enable = lib.mkEnableOption "Enable Borg backup job";
  };

  config = lib.mkIf config.custom.borgbackup.enable {
    services.borgbackup.jobs."borgbackup-job" = {
      user = "${settings.username}";
      paths = "/home/${settings.username}/Syncthing";
      encryption.mode = "none";
      repo = "/home/${settings.username}/Syncthing-backup";
      compression = "auto,zstd";
      startAt = "daily";
      prune.keep = {
        weekly = 1;
        monthly = 1;
        yearly = 1;
      };
      postHook = ''
        ${pkgs.borgbackup}/bin/borg compact ${config.services.borgbackup.jobs."borgbackup-job".repo}
      '';
    };

    systemd.services."borg-backup-create-directory" = {
      description = "Create backup directory for Borg if needed";
      before = [ "borgbackup-job.service" ];
      wantedBy = [ "borgbackup-job.service" ];
      serviceConfig = {
        Type = "oneshot";
      };
      script = ''
        mkdir -p ${config.services.borgbackup.jobs."borgbackup-job".repo}
      '';
    };
  };
}
