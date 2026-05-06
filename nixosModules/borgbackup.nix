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
    services.borgbackup.jobs."borgbackup-job" = {
      user = "${settings.username}";
      paths = "/home/${settings.username}/Syncthing";
      encryption.mode = "none";
      repo = "/home/${settings.username}/Syncthing-backup";
      compression = "auto,zstd";
      startAt = "monthly";
      prune.keep = {
        monthly = 2;
      };
      postInit = ''
        if [[ ! -d ${config.services.borgbackup.jobs."borgbackup-job".repo} ]]; then
          ${pkgs.borgbackup}/bin/borg init \
            --encryption=${config.services.borgbackup.jobs."borgbackup-job".encryption.mode} \
            ${config.services.borgbackup.jobs."borgbackup-job".repo}
        fi
      '';
      postHook = ''
        ${pkgs.borgbackup}/bin/borg compact ${config.services.borgbackup.jobs."borgbackup-job".repo}
      '';
    };
  };
}
