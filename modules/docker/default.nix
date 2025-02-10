{
 imports = [
   ./docker.nix
   #./dockur_output.nix
   #./headscale_output.nix
   ./jellyfin_output.nix
   ./nextcloud_output.nix
   ./nginx_reverse_proxy_output.nix
   ./pi-hole_output.nix
   ./portainer_output.nix
   ./uptime-kuma_output.nix
   ./vpn_output.nix
   ./watchtower_output.nix
  ];

  # Run with compose2nix: compose2nix -inputs input.yml -output output.nix -runtime docker
}
