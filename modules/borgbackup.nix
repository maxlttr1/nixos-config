{ settings, ... }:

{
  services.borgbackup.jobs.home-danbst = {
    user = "${settings.username}";
    paths = "/home/${settings.username}/Downloads";
    encryption.mode = "none";
    repo = "/home/${settings.username}/Downloads-backup";
    compression = "auto,zstd";
    startAt = "monthly";
  };
}