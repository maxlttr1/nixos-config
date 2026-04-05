{ pkgs, settings, config, lib, ... }:

let
  starting_script = pkgs.writeShellScript "starting_script" ''
    export PUID=$(id -u)
    export PGID=$(id -g)
    export TAILSCALE_IP=$(${pkgs.tailscale}/bin/tailscale ip -4)

    if [ ! -d "nixos-config" ]; then
      ${pkgs.git}/bin/git clone https://github.com/maxlttr1/nixos-config.git
    fi
    cd nixos-config/
    ${pkgs.git}/bin/git checkout master
    ${pkgs.git}/bin/git pull origin master

    if [ ! -f $HOME/docker/suaps/config.json ]; then
      mkdir -p $HOME/docker/suaps
      echo '{ "ids_resa": [] }' > $HOME/docker/suaps/config.json
    fi

    if [ ! -f $HOME/docker/traefik/acme.json ]; then
      mkdir -p $HOME/docker/traefik
      touch $HOME/docker/traefik/acme.json && chmod 600 $HOME/docker/traefik/acme.json
    fi

    # Create proxy network if not present for traefik
    if ! ${pkgs.docker}/bin/docker network inspect proxy >/dev/null 2>&1; then
      ${pkgs.docker}/bin/docker network create proxy
    fi

    for file in ./nixosModules/common/docker/active/*.yml; do
      name=$(basename "$file" .yml)
      ${pkgs.docker}/bin/docker compose -p $name -f $file up -d &
    done
    wait

    cd ..
    rm -r nixos-config/
  '';

  stopping_script = pkgs.writeShellScript "stopping_script" ''
    export PUID=$(id -u)
    export PGID=$(id -g)
    export TAILSCALE_IP=$(${pkgs.tailscale}/bin/tailscale ip -4)

    if [ ! -d "nixos-config" ]; then
      ${pkgs.git}/bin/git clone https://github.com/maxlttr1/nixos-config.git
    fi
    cd nixos-config/
    ${pkgs.git}/bin/git checkout master
    ${pkgs.git}/bin/git pull origin master

    for file in ./nixosModules/common/docker/active/*.yml; do
      name=$(basename "$file" .yml)
      ${pkgs.docker}/bin/docker compose -p $name -f $file down -v --remove-orphans
    done

    ${pkgs.docker}/bin/docker system prune -a --volumes -f

    cd ..
    rm -r nixos-config/
  '';
in

{
  options = {
    custom.docker.enable = lib.mkEnableOption "Enable automatic Docker container management";
  };

  config = lib.mkIf config.custom.docker.enable {
    virtualisation.docker = {
      enable = true;
    };

    users.users.${settings.username}.extraGroups = [ "docker" ];

    systemd.services."docker-containers-start" = {
      description = "Start Docker containers";

      serviceConfig = {
        WorkingDirectory = "/tmp/";
        User = "${settings.username}";
        Type = "oneshot";
        ExecStart = "${starting_script}";

        ProtectSystem = "strict";
        ProtectHome = "read-only";
        ReadWritePaths = [
          "/tmp/"
        ];
        NoNewPrivileges = true;
        ProtectKernelLogs = true;
        ProtectKernelModules = true;
        ProtectKernelTunables = true;
      };
    };

    systemd.services."docker-containers-stop" = {
      description = "Stop Docker containers";

      serviceConfig = {
        WorkingDirectory = "/tmp/";
        User = "${settings.username}";
        Type = "oneshot";
        ExecStart = "${stopping_script}";

        ProtectSystem = "strict";
        ProtectHome = "read-only";
        ReadWritePaths = [
          "/tmp/"
        ];
        NoNewPrivileges = true;
        ProtectKernelLogs = true;
        ProtectKernelModules = true;
        ProtectKernelTunables = true;
      };
    };
  };
}

