{
 imports = [
   ./docker.nix
   #./dockur_output.nix
   ./jellyfin_output.nix
   ./nginx_reverse_proxy_output.nix
   #./portainer_output.nix
   ./vpn_output.nix
  ];

  # Run with compose2nix: compose2nix -inputs input.yml -output output.nix -runtime docker
}
