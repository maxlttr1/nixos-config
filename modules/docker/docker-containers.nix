{ pkgs, ... }:

let
  starting_script = pkgs.writeShellScript "starting_script" ''
    if [ ! -d "nixos-config" ]; then
      ${pkgs.git}/bin/git clone https://github.com/maxlttr1/nixos-config.git
    fi
    cd nixos-config/
    ${pkgs.git}/bin/git checkout docker_rebase
    ${pkgs.git}/bin/git pull origin docker_rebase

    # Start all the containers
    for file in ./modules/docker/ymls/*.yml; do
      name=$(basename "$file" .yml)
      ${pkgs.docker}/bin/docker compose -p $name -f $file up -d
    done

    cd ..
    rm -r nixos-config/
  '';

  stopping_script = pkgs.writeShellScript "stopping_script" ''
    if [ ! -d "nixos-config" ]; then
      ${pkgs.git}/bin/git clone https://github.com/maxlttr1/nixos-config.git
    fi
    cd nixos-config/
    ${pkgs.git}/bin/git checkout docker_rebase
    ${pkgs.git}/bin/git pull origin docker_rebase

    # Stop all containers started by docker compose
    for file in ./modules/docker/ymls/*.yml; do
      name=$(basename "$file" .yml)
      ${pkgs.docker}/bin/docker compose -p $name -f $file down -v --remove-orphans
    done

    # Remove all images not used by any container.
    ${pkgs.docker}/bin/docker image prune -a -f
    # Remove all unused volumes
    ${pkgs.docker}/bin/docker volume prune -f
    # Remove all unused networks
    ${pkgs.docker}/bin/docker network prune -f


    cd ..
    rm -r nixos-config/
  ''; 
in

{
  /*imports = [
    ./deluge/deluge.nix
    ./jellyfin/jellyfin.nix
    ./n8n/n8n.nix
    ./portainer/portainer.nix
    ./traefik/traefik.nix
    ./uptime-kuma/uptime-kuma.nix
    ./watchtower/watchtower.nix
  ];*/

  # Run with compose2nix: compose2nix -inputs input.yml -output output.nix -runtime docker

  /*
  environment = {
      "VPN_SERVICE_PROVIDER" = "custom";
      "VPN_TYPE" = "wireguard";
  };
  environmentFiles = [ config.sops.secrets."vpn.env".path ];
  */

  systemd.services."docker-containers-management" = {
    description = "Manage Docker containers";

    wantedBy = [ "multi-user.target" ];
    After = [ "docker.service" ];
    Requires = [ "docker.service" ];

    serviceConfig = {
      WorkingDirectory = "/tmp/";
      Environment = "HOME=/root";
      ExecStart = "${starting_script}";
      ExecStop = "${stoping_script}";
    };
  };
}
