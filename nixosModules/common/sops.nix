{
  config,
  lib,
  settings,
  ...
}:

{
  options.custom.sops.enable = lib.mkEnableOption "Essentials sops-nix secrets";

  config = lib.mkIf config.custom.sops.enable {
    sops = {
      defaultSopsFile = ../../secrets/secrets.yaml;
      defaultSopsFormat = "yaml";
      age.keyFile = "/etc/sops/age/keys.txt";

      secrets = {
        "github/token" = {
          mode = "0600";
          owner = config.users.users."${settings.username}".name;
          group = config.users.users."${settings.username}".group;
        };
        "discord/webhook" = {
          mode = "0600";
          owner = config.users.users."${settings.username}".name;
          group = config.users.users."${settings.username}".group;
        };
        "borgbackup/docker-containers-volumes" = {
          mode = "0600";
        };
        "nextcloud/url" = {
          mode = "0600";
          owner = config.users.users."${settings.username}".name;
          group = config.users.users."${settings.username}".group;
        };
        "nextcloud/secret" = {
          mode = "0600";
          owner = config.users.users."${settings.username}".name;
          group = config.users.users."${settings.username}".group;
        };
        "nextcloud/conversations/Nixos" = {
          mode = "0600";
          owner = config.users.users."${settings.username}".name;
          group = config.users.users."${settings.username}".group;
        };
      };
    };
  };
}
