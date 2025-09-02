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
      monthly = 1;
    };
    # One backup each week but only the newest is kept each month. This way you got 1 backup each month.
  };
}