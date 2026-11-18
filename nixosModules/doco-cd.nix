{
  config,
  lib,
  pkgs,
  settings,
  ...
}:

{
  options = {
    custom.doco-cd.enable = lib.mkEnableOption "Enable automatic Docker container management via doco-cd";
  };

  config = lib.mkIf (config.custom.docker.enable && config.custom.doco-cd.enable) {
    users.users.${settings.username}.uid = 1002;

    virtualisation.oci-containers = {
      backend = "docker";
      containers = {
        doco-cd = {
          image = "ghcr.io/kimdre/doco-cd:latest";
          autoStart = true;
          environment = {
            TZ = "Europe/Berlin";
            GIT_AUTH_DOMAINS = "- domains: [forgejo.maxlttr.fr, github.com]";
            POLL_CONFIG = ''
              - url: https://forgejo.maxlttr.fr/maxlttr/nixos-config.git
                reference: master
                interval: 300
            '';
            DEPLOY_CONFIG_BASE_DIR = "deployments/docker";
            PASS_ENV = "true";
            TAILSCALE_IP = "100.68.245.10";
            PUID = lib.toString config.users.users."${settings.username}".uid;
            PGID = "100"; # Users group ID
          };
          volumes = [
            "/var/run/docker.sock:/var/run/docker.sock"
            "doco-cd:/data"
          ];
          extraOptions = [
            "--cap-drop=ALL"
            # "--health-start-period=15s"
            # "--health-interval=30s"
            # "--health-timeout=5s"
            # "--health-retries=3"
          ];
        };
      };
    };

    system.activationScripts = {
      "init-docker-infra" = {
        text = ''
          # Networks
          ${pkgs.docker}/bin/docker network inspect proxy >/dev/null 2>&1 || ${pkgs.docker}/bin/docker network create proxy
          ${pkgs.docker}/bin/docker network inspect local_websecure >/dev/null 2>&1 || ${pkgs.docker}/bin/docker network create local_websecure

          # Volumes
          ${pkgs.docker}/bin/docker volume inspect shared_movies >/dev/null 2>&1 || ${pkgs.docker}/bin/docker volume create shared_movies
          ${pkgs.docker}/bin/docker volume inspect shared_tvshows >/dev/null 2>&1 || ${pkgs.docker}/bin/docker volume create shared_tvshows
          ${pkgs.docker}/bin/docker volume inspect shared_i2ptorrents >/dev/null 2>&1 || ${pkgs.docker}/bin/docker volume create shared_i2ptorrents
          ${pkgs.docker}/bin/docker volume inspect suaps-config >/dev/null 2>&1 || ${pkgs.docker}/bin/docker volume create suaps-config

          # Files initialization
          ${pkgs.docker}/bin/docker run --rm -v suaps-config:/v alpine sh -c '
            if [ ! -f /v/config.json ]; then
              echo "{ \"ids_resa\": [] }" > /v/config.json
            fi
          '
          ${pkgs.docker}/bin/docker run --rm -v traefik:/v alpine sh -c '
            if [ ! -f /v/acme.json ]; then
              touch /v/acme.json && chmod 600 /v/acme.json
            fi
          '
        '';
      };
    };
  };
}
