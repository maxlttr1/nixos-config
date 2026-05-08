{ config, lib, ... }:

{
  options.custom.sops.enable = lib.mkEnableOption "Essentials sops-nix secrets";

  config = lib.mkIf config.custom.sops.enable {
    # See ~/.config/sops-nix/secrets/ for the decrypted files
    sops = {
      defaultSopsFile = ../../secrets/secrets.yaml;
      defaultSopsFormat = "yaml";
      age.keyFile = "/etc/sops/age/keys.txt";

      secrets = {
        "github-token" = {
          mode = "0600";
        };
        "vpn.env" = {
          mode = "0600";
        };
        "suaps.env" = {
          mode = "0600";
        };
        "discord-webhook" = {
          mode = "0600";
        };
      };
    };
  };
}
