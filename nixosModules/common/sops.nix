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
        };
        "discord/webhook" = {
          mode = "0600";
        };
        "gotify/nixos-upgrade" = {
          mode = "0600";
        };
      };
    };
  };
}
