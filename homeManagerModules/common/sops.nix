{
  config,
  lib,
  hostname,
  ...
}:

{
  options.custom.sops.enable = lib.mkEnableOption "Essentials sops-nix secrets";

  config = lib.mkIf config.custom.sops.enable {
    # See ~/.config/sops-nix/secrets/ for the decrypted files
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
        "gotify/nixos-upgrade" = {
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
        "env/vpn.env" = {
          key = "env/vpn";
          mode = "0600";
        };
        "env/suaps.env" = {
          key = "env/suaps";
          mode = "0600";
        };
      }
      // lib.optionalAttrs (hostname == "terra-terra" || hostname == "vm-desktop") {
        "ssh/github/private" = {
          mode = "0600";
        };
        "ssh/github/public" = {
          mode = "0640";
        };
        "ssh/nixos-setup/private" = {
          mode = "0600";
        };
        "ssh/nixos-setup/public" = {
          mode = "0640";
        };
        "ssh/racknerd/ip" = {
          mode = "0600";
        };
        "ssh/racknerd/private" = {
          mode = "0600";
        };
        "ssh/racknerd/public" = {
          mode = "0640";
        };
        "ssh/gitlab-univ-nantes/private" = {
          mode = "0600";
        };
        "ssh/gitlab-univ-nantes/public" = {
          mode = "0640";
        };
      };
    };
  };
}
