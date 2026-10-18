{
  lib,
  config,
  pkgs,
  settings,
  hostname,
  ...
}:

{
  options = {
    custom.borgbackup.enable = lib.mkEnableOption "Enable Borg backup job";
  };

  config = lib.mkIf config.custom.borgbackup.enable {
    services.borgbackup.jobs = {
      "borgbackup-job" = lib.mkIf config.custom.syncthing.enable {
        user = "${settings.username}";
        paths = "/home/${settings.username}/Syncthing";
        /*
          encryption = {
            mode = "repokey-blake2";
            passCommand = "cat ${config.sops.secrets."borgbackup/borgbackup-job".path}";
          };
        */
        encryption.mode = "none";
        repo = "/home/${settings.username}/Syncthing-backup";
        compression = "auto,zstd";
        startAt = "daily";
        prune.keep = {
          daily = 7;
          weekly = 4;
          monthly = 3;
        };
        persistentTimer = true;
        /*
          postInit = ''
            if [[ ! -d ${config.services.borgbackup.jobs."borgbackup-job".repo} ]]; then
              ${pkgs.borgbackup}/bin/borg init \
                --encryption=${config.services.borgbackup.jobs."borgbackup-job".encryption.mode} \
                ${config.services.borgbackup.jobs."borgbackup-job".repo}
            fi
          '';
        */
        postHook = ''
          ${pkgs.borgbackup}/bin/borg compact ${config.services.borgbackup.jobs."borgbackup-job".repo}
        '';
      };
      "borgbackup-docker-containers-volumes" =
        lib.mkIf (config.custom.docker.enable && hostname == "nexus-nexus")
          {
            user = "root";
            paths = "/var/lib/docker-containers";
            exclude = [
              "/var/lib/docker-containers/movies"
              "/var/lib/docker-containers/tvshows"
              "/var/lib/docker-containers/i2p/i2ptorrents/*"
            ];
            encryption = {
              mode = "repokey-blake2";
              passCommand = "cat ${config.sops.secrets."borgbackup/docker-containers-volumes".path}";
            };
            repo = "/var/lib/docker-containers-backup";
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
                config.services.borgbackup.jobs."borgbackup-docker-containers-volumes".repo
              }
            '';
          };
    };
  };
}
