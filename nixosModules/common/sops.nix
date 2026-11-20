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
          mode = "0400";
          owner = config.users.users."${settings.username}".name;
          group = config.users.users."${settings.username}".group;
        };
        "nextcloud/url" = {
          mode = "0400";
          owner = config.users.users."${settings.username}".name;
          group = config.users.users."${settings.username}".group;
        };
        "nextcloud/secret" = {
          mode = "0400";
          owner = config.users.users."${settings.username}".name;
          group = config.users.users."${settings.username}".group;
        };
        "nextcloud/conversations/Nixos" = {
          mode = "0400";
          owner = config.users.users."${settings.username}".name;
          group = config.users.users."${settings.username}".group;
        };
      }
      // lib.optionalAttrs (hostname == "nexus-nexus") {
        "borgbackup/borgbackup-job-home-stack" = {
          mode = "0400";
        };
        # Docker containers secrets
        "env/watchtower/notifications_urls.txt" = {
          key = "env/watchtower/notifications_urls";
          mode = "0400";
        };
        "env/overleaf.env" = {
          key = "env/overleaf";
          mode = "0400";
        };
        "env/ovh-perm.env" = {
          key = "env/ovh-perm";
          mode = "0400";
        };
        "env/homarr.env" = {
          key = "env/homarr";
          mode = "0400";
        };
        "env/vpn.env" = {
          key = "env/vpn";
          mode = "0400";
        };
        "env/suaps.env" = {
          key = "env/suaps";
          mode = "0400";
        };
        # For nixos-flake-update service
        "ssh/forgejo/token" = {
          mode = "0400";
          owner = config.users.users."${settings.username}".name;
          group = config.users.users."${settings.username}".group;
        };
      };
    };
  };
}
