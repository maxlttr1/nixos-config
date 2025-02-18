{
 imports = [
   ./docker.nix
   ./jellyfin.nix
   ./nextcloud.nix
   ./npm.nix
   ./pihole.nix
   ./portainer.nix
   ./uptime-kuma.nix
   ./vpn.nix
   ./watchtower.nix
  ];

  # Run with compose2nix: compose2nix -inputs input.yml -output output.nix -runtime docker
  # environmentFiles = [ config.sops.secrets."vpn.env".path ];
}
