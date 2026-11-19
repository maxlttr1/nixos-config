{
  lib,
  config,
  pkgs,
  settings,
  ...
}:

{
  options = {
    custom.borgbackup.enable = lib.mkEnableOption "Enable Borg backup job";
  };

  config = lib.mkIf config.custom.borgbackup.enable {
    systemd.tmpfiles.rules = [
      # "d /tmp 1777 root root 10d"
      "d ${config.services.borgbackup.jobs."borgbackup-job-home-stack".repo} 0700 ${
        config.services.borgbackup.jobs."borgbackup-job-home-stack".user
      } ${config.services.borgbackup.jobs."borgbackup-job-home-stack".user} -"
    ];

    services.borgbackup.jobs = {
      "borgbackup-job-home-stack" = {
        user = "root";
        paths = "/var/lib/docker/volumes";
        exclude = [
          "/var/lib/docker/volumes/shared*"
          "/var/lib/docker/volumes/nextcloud*"
          "re:^/var/lib/docker/volumes/[a-f0-9]{64}$" # Matches directory names consisting of exactly 64 hexadecimal characters (anonymous Docker volumes)
        ];
        encryption = {
          mode = "repokey-blake2";
          passCommand = "cat ${config.sops.secrets."borgbackup/borgbackup-job-home-stack".path}";
        };
        repo = "/home/${settings.username}/borgbackup-job-home-stack";
        compression = "auto,zstd";
        startAt = "daily";
        prune.keep = {
          daily = 7;
          weekly = 4;
          monthly = 3;
        };
        persistentTimer = true;
        postHook = ''
          ${pkgs.borgbackup}/bin/borg compact ${
            config.services.borgbackup.jobs."borgbackup-job-home-stack".repo
          }
        '';
      };
    };
  };
}
