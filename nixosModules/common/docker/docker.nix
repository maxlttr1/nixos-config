{ pkgs, settings, config, lib, ... }:

let
  starting_script = pkgs.writeShellScript "starting_script" ''
    if [ ! -d "nixos-config" ]; then
      ${pkgs.git}/bin/git clone https://github.com/maxlttr1/nixos-config.git
    fi
    cd nixos-config/
    ${pkgs.git}/bin/git checkout master
    ${pkgs.git}/bin/git pull origin master

    if [ ! -f ~/docker/suaps/config.json ]; then
      mkdir -p ~/docker/suaps
      echo '{ "ids_resa": [] }' > ~/docker/suaps/config.json
    fi

    # Create proxy network if not present for traefik
    if ! ${pkgs.docker}/bin/docker network inspect proxy >/dev/null 2>&1; then
      ${pkgs.docker}/bin/docker network create proxy
    fi

    # Start all the containers
    for file in ./nixosModules/common/docker/active/*.yml; do
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
    ${pkgs.git}/bin/git checkout master
    ${pkgs.git}/bin/git pull origin master

    # Stop all containers started by docker compose
    for file in ./nixosModules/common/docker/active/*.yml; do
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
  options = {
    docker.enable = lib.mkEnableOption "Enable automatic Docker container management";
  };

  config = lib.mkIf config.docker.enable {
    virtualisation.docker = {
      enable = true;
    };
    users.users.${settings.username}.extraGroups = [ "docker" ];

    systemd.services."docker-containers-start" = {
      description = "Start Docker containers";

      serviceConfig = {
        WorkingDirectory = "/tmp/";
        Environment = "HOME=/home/${settings.username}";
        User = "root";
        Type = "oneshot";
        ExecStart = "${starting_script}";
      };
    };

    systemd.services."docker-containers-stop" = {
      description = "Stop Docker containers";

      serviceConfig = {
        WorkingDirectory = "/tmp/";
        Environment = "HOME=/home/${settings.username}";
        User = "root";
        Type = "oneshot";
        ExecStart = "${stopping_script}";
      };
    };
  };
}

