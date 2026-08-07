{
  pkgs,
  settings,
  config,
  lib,
  ...
}:

{
  options = {
    custom.docker.enable = lib.mkEnableOption "Enable automatic Docker container management";
  };

  config = lib.mkIf config.custom.docker.enable {
    virtualisation.docker = {
      enable = true;
    };

    users.users.${settings.username}.extraGroups = [ "docker" ];

    systemd.services."docker-containers" = {
      description = "Docker container management";
      after = [ 
        "docker.service"
        "network-online.target"
        "tailscaled.service"
      ];
      wants = [ 
        "docker.service"
        "network-online.target"
        "tailscaled.service"
      ];
      serviceConfig = {
        Type = "oneshot";
        User = "${settings.username}";

        ProtectSystem = "strict";
        ProtectHome="read-only";
        CacheDirectory = "docker-containers";
        CacheDirectoryMode = "0700";
        StateDirectory = "docker-containers";
        StateDirectoryMode = "0700";
        WorkingDirectory = "/var/cache/docker-containers";

        RemainAfterExit = true;
        
        NoNewPrivileges = true;
        ProtectKernelLogs = true;
        ProtectKernelModules = true;
        ProtectKernelTunables = true;
      };
      preStart = ''
        set -euox pipefail

        if [ ! -d "nixos-config" ]; then
          ${pkgs.git}/bin/git clone https://github.com/maxlttr1/nixos-config.git ./nixos-config
        fi

        cd nixos-config/
        ${pkgs.git}/bin/git fetch origin master
        ${pkgs.git}/bin/git checkout master
        ${pkgs.git}/bin/git reset --hard origin/master
      '';
      script = ''
        set -euox pipefail

        export PUID=$(id -u)
        export PGID=$(id -g)
        export TAILSCALE_IP=$(${pkgs.tailscale}/bin/tailscale ip -4)
        export STATE_DIRECTORY="$STATE_DIRECTORY"

        cd nixos-config/

        if [ ! -f $STATE_DIRECTORY/suaps/config.json ]; then
          mkdir -p $STATE_DIRECTORY/suaps
          echo '{ "ids_resa": [] }' > $STATE_DIRECTORY/suaps/config.json
        fi

        if [ ! -f $STATE_DIRECTORY/traefik/acme.json ]; then
          mkdir -p $STATE_DIRECTORY/traefik
          touch $STATE_DIRECTORY/traefik/acme.json && chmod 600 $STATE_DIRECTORY/traefik/acme.json
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
      '';
      preStop = ''
        set -euox pipefail

        export PUID=$(id -u)
        export PGID=$(id -g)
        export TAILSCALE_IP=$(${pkgs.tailscale}/bin/tailscale ip -4)
        export STATE_DIRECTORY="$STATE_DIRECTORY"

        cd nixos-config/

        for file in ./nixosModules/common/docker/active/*.yml; do
          name=$(basename "$file" .yml)
          ${pkgs.docker}/bin/docker compose -p $name -f $file down -v --remove-orphans
        done

        # ${pkgs.docker}/bin/docker system prune -a --volumes -f
      '';
    };
  };
}
