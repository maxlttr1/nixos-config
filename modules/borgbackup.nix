{ settings, ... }:

{
  services.borgbackup.jobs.home-danbst = {
    user = "${settings.username}";
    paths = "/home/${settings.username}/Syncthing";
    encryption.mode = "none";
    repo = "/home/${settings.username}/Syncthing-backup";
    compression = "auto,zstd";
    startAt = "weekly";
    prune.keep = {
      within = "7d";
      monthly = 1;
      yearly = 1;
    };

  };
}