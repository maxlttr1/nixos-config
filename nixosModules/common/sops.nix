{
  config,
  lib,
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
        };
        "discord/webhook" = {
          mode = "0600";
        };
        "borgbackup/docker-containers-volumes" = {
          mode = "0600";
        };
        "borgbackup/borgbackup-job" = {
          mode = "0600";
        };
        "nextcloud/url" = {
          mode = "0600";
        };
        "nextcloud/secret" = {
          mode = "0600";
        };
        "nextcloud/conversations/Nixos" = {
          mode = "0600";
        };
      };
    };
  };
}
