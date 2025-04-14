{
  imports = [
    ./docker.nix
    ./deluge/deluge.nix
    ./it-tools/it-tools.nix
    ./jellyfin/jellyfin.nix
    ./pihole/pihole.nix
    ./portainer/portainer.nix
    ./searxng/searxng.nix
    ./traefik/traefik.nix
    ./uptime-kuma/uptime-kuma.nix
    ./watchtower/watchtower.nix
  ];

  # Run with compose2nix: compose2nix -inputs input.yml -output output.nix -runtime docker

  /*
  environment = {
      "VPN_SERVICE_PROVIDER" = "custom";
      "VPN_TYPE" = "wireguard";
  };
  environmentFiles = [ config.sops.secrets."vpn.env".path ];
  */
}
