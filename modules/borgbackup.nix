{ settings, ... }:

{
  services.borgbackup.jobs.home-danbst = {
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
  };
}