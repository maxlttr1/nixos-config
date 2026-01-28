{ lib, config, ... }:

{
  options = {
    borgbackup.enable = lib.mkEnableOption "Enable Borg backup job";
  };

  config = lib.mkIf config.borgbackup.enable {
    services.borgbackup.jobs.home-danbst = {
      user = "${config.users.mainUsername}";
      paths = "/home/${config.users.mainUsername}/Syncthing";
      encryption.mode = "none";
      repo = "/home/${config.users.mainUsername}/Syncthing-backup";
      compression = "auto,zstd";
      startAt = "daily";
      prune.keep = {
        weekly = 1;
        monthly = 1;
        yearly = 1;
      };
    };
  };
}
