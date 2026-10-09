{ config, lib, ... }:

{
  options.custom.sops.enable = lib.mkEnableOption "Essentials sops-nix secrets";

  config = lib.mkIf config.custom.sops.enable {
    sops = {
      defaultSopsFile = ../../secrets/secrets.yaml;
      defaultSopsFormat = "yaml";
      age.keyFile = "/etc/sops/age/keys.txt";

      secrets = { };
    };
  };
}
