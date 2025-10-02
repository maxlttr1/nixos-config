{ pkgs, settings, ... }:

let
  starting_script = pkgs.writeShellScript "starting_script" ''
    if [ ! -d "nixos-config" ]; then
      ${pkgs.git}/bin/git clone https://github.com/maxlttr1/nixos-config.git
    fi
    cd nixos-config/
    ${pkgs.git}/bin/git checkout docker_rebase
    ${pkgs.git}/bin/git pull origin docker_rebase

    # Create proxy network if not present for traefik
    if ! ${pkgs.docker}/bin/docker network inspect proxy >/dev/null 2>&1; then
      ${pkgs.docker}/bin/docker network create proxy
    fi

    # Start all the containers
    for file in ./modules/docker/ymls/*.yml; do
      name=$(basename "$file" .yml)
      ${pkgs.docker}/bin/docker compose -p $name -f $file up -d &
    done
    wait
    
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

    # Remove unused data (append `--volumes` to remove unused volumes as well)
    ${pkgs.docker}/bin/docker system prune -a --volumes -f

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

  systemd.services."docker-containers-start" = {
    description = "Start Docker containers";

    serviceConfig = {
      WorkingDirectory = "/tmp/";
      Environment = "HOME=/home/${settings.username}";
      User = settings.username;
      Type = "oneshot";
      ExecStart = "${starting_script}";
    };
  };

  systemd.services."docker-containers-stop" = {
    description = "Stop Docker containers";

    serviceConfig = {
      WorkingDirectory = "/tmp/";
      Environment = "HOME=/home/${settings.username}";
      User = settings.username;
      Type = "oneshot";
      ExecStart = "${stopping_script}";
    };
  };
}
