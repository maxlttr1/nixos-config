{
 imports = [
   ./docker.nix
   ./jellyfin/jellyfin.nix
   #./nextcloud/nextcloud.nix
   ./pihole/pihole.nix
   ./portainer/portainer.nix
   ./traefik/traefik.nix
   ./uptime-kuma/uptime-kuma.nix
   ./vpn/vpn.nix
   ./watchtower/watchtower.nix
   ./wg-easy/wg-easy.nix
  ];

  # Run with compose2nix: compose2nix -inputs input.yml -output output.nix -runtime docker
  # environmentFiles = [ config.sops.secrets."vpn.env".path ];
}
