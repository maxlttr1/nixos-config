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
        "ssh/racknerd/ip" = {
          mode = "0600";
        };
        "ssh/racknerd/private" = {
          mode = "0600";
        };
      }
      // lib.optionalAttrs (hostname == "terra-terra" || hostname == "vm-desktop") {
        "ssh/forgejo/private" = {
          mode = "0600";
        };
        "ssh/nixos-setup/private" = {
          mode = "0600";
        };
        "ssh/gitlab-univ-nantes/private" = {
          mode = "0600";
        };
        "ssh/github/private" = {
          mode = "0600";
        };
      };
    };
  };
}
