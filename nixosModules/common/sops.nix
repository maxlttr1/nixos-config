{
  config,
  lib,
  settings,
  hostname,
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
        # Notifications for systemUpgrade
        "discord/webhook" = {
          mode = "0600";
          owner = config.users.users."${settings.username}".name;
          group = config.users.users."${settings.username}".group;
        };
        "borgbackup/docker-containers-volumes" = {
          mode = "0600";
        };
        "borgbackup/docker-containers-volumes-external" = {
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
      }
      // lib.optionalAttrs (hostname == "nexus-nexus") {
        # Docker containers secrets
        "env/ovh-perm.env" = {
          key = "env/ovh-perm";
          mode = "0600";
          owner = config.users.users."${settings.username}".name;
          group = config.users.users."${settings.username}".group;
        };
        "env/homarr.env" = {
          key = "env/homarr";
          mode = "0600";
          owner = config.users.users."${settings.username}".name;
          group = config.users.users."${settings.username}".group;
        };
        "env/vpn.env" = {
          key = "env/vpn";
          mode = "0600";
          owner = config.users.users."${settings.username}".name;
          group = config.users.users."${settings.username}".group;
        };
        "env/suaps.env" = {
          key = "env/suaps";
          mode = "0600";
          owner = config.users.users."${settings.username}".name;
          group = config.users.users."${settings.username}".group;
        };
        # For nixos-flake-update service
        "ssh/forgejo/token" = {
          mode = "0600";
          owner = config.users.users."${settings.username}".name;
          group = config.users.users."${settings.username}".group;
        };
      };
    };
  };
}
