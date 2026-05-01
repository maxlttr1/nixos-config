{ config, lib, settings, ... }:

{
  options.custom.sops.enable = lib.mkEnableOption "sops-nix secrets management";

  config = lib.mkIf config.custom.sops.enable {
    # See ~/.config/sops-nix/secrets/ for the decrypted files

    sops = {
      defaultSopsFile = ../../secrets/secrets.yaml;
      defaultSopsFormat = "yaml";
      age.keyFile = "/etc/sops/age/keys.txt";

      secrets = {
        "github-token" = { mode = "0600"; };
        "vpn.env" = { mode = "0600"; };
        "suaps.env" = { mode = "0600"; };
        "nixos_ssh_setup.public" = { mode = "0640"; };
        "nixos_ssh_setup.private" = { mode = "0600"; };
        "racknerd_ip" = { mode = "0600"; };
        "racknerd_ssh.public" = { mode = "0640"; };
        "racknerd_ssh.private" = { mode = "0600"; };
        "gitlab-univ-nantes.public" = { mode = "0640"; };
        "gitlab-univ-nantes.private" = { mode = "0600"; };
        "discord-webhook" = { mode = "0600"; };
      };
    };
  };
}
