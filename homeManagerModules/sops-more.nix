{ config, lib, ... }:

{
  options.custom.sops-more.enable = lib.mkEnableOption "More sops-nix secrets";

  config = lib.mkIf config.custom.sops-more.enable {
    sops.secrets = {
      "github.public" = {
        mode = "0640";
      };
      "github.private" = {
        mode = "0600";
      };
      "nixos_ssh_setup.public" = {
        mode = "0640";
      };
      "nixos_ssh_setup.private" = {
        mode = "0600";
      };
      "racknerd_ip" = {
        mode = "0600";
      };
      "racknerd_ssh.public" = {
        mode = "0640";
      };
      "racknerd_ssh.private" = {
        mode = "0600";
      };
      "gitlab-univ-nantes.public" = {
        mode = "0640";
      };
      "gitlab-univ-nantes.private" = {
        mode = "0600";
      };
    };
  };
}
