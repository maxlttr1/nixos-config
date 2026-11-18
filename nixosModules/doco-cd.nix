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
              - url: https://github.com/maxlttr1/nixos-config.git
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
            "/run/secrets:/run/secrets:ro"
          ];
          extraOptions = [
            # "--cap-drop=ALL"
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
          ${pkgs.docker}/bin/docker volume inspect deluge >/dev/null 2>&1 || ${pkgs.docker}/bin/docker volume create deluge
          ${pkgs.docker}/bin/docker volume inspect shared_movies >/dev/null 2>&1 || ${pkgs.docker}/bin/docker volume create shared_movies
          ${pkgs.docker}/bin/docker volume inspect shared_tvshows >/dev/null 2>&1 || ${pkgs.docker}/bin/docker volume create shared_tvshows
          ${pkgs.docker}/bin/docker volume inspect forgejo >/dev/null 2>&1 || ${pkgs.docker}/bin/docker volume create forgejo
          ${pkgs.docker}/bin/docker volume inspect homarr >/dev/null 2>&1 || ${pkgs.docker}/bin/docker volume create homarr
          ${pkgs.docker}/bin/docker volume inspect i2pconfig >/dev/null 2>&1 || ${pkgs.docker}/bin/docker volume create i2pconfig
          ${pkgs.docker}/bin/docker volume inspect shared_i2ptorrents >/dev/null 2>&1 || ${pkgs.docker}/bin/docker volume create shared_i2ptorrents
          ${pkgs.docker}/bin/docker volume inspect jellyfin_library >/dev/null 2>&1 || ${pkgs.docker}/bin/docker volume create jellyfin_library
          ${pkgs.docker}/bin/docker volume inspect openwebui_data >/dev/null 2>&1 || ${pkgs.docker}/bin/docker volume create openwebui_data
          ${pkgs.docker}/bin/docker volume inspect openwebui_ollama >/dev/null 2>&1 || ${pkgs.docker}/bin/docker volume create openwebui_ollama
          ${pkgs.docker}/bin/docker volume inspect portainer_data >/dev/null 2>&1 || ${pkgs.docker}/bin/docker volume create portainer_data
          ${pkgs.docker}/bin/docker volume inspect overleaf-data >/dev/null 2>&1 || ${pkgs.docker}/bin/docker volume create overleaf-data
          ${pkgs.docker}/bin/docker volume inspect overleaf-logs >/dev/null 2>&1 || ${pkgs.docker}/bin/docker volume create overleaf-logs
          ${pkgs.docker}/bin/docker volume inspect overleaf-mongo >/dev/null 2>&1 || ${pkgs.docker}/bin/docker volume create overleaf-mongo
          ${pkgs.docker}/bin/docker volume inspect overleaf-redis >/dev/null 2>&1 || ${pkgs.docker}/bin/docker volume create overleaf-redis
          ${pkgs.docker}/bin/docker volume inspect suaps-config >/dev/null 2>&1 || ${pkgs.docker}/bin/docker volume create suaps-config
          ${pkgs.docker}/bin/docker volume inspect traefik >/dev/null 2>&1 || ${pkgs.docker}/bin/docker volume create traefik
          ${pkgs.docker}/bin/docker volume inspect uptime-kuma >/dev/null 2>&1 || ${pkgs.docker}/bin/docker volume create uptime-kuma
          ${pkgs.docker}/bin/docker volume inspect vaultwarden >/dev/null 2>&1 || ${pkgs.docker}/bin/docker volume create vaultwarden
          ${pkgs.docker}/bin/docker volume inspect freshrss_extensions >/dev/null 2>&1 || ${pkgs.docker}/bin/docker volume create freshrss_extensions
          ${pkgs.docker}/bin/docker volume inspect freshrss_data >/dev/null 2>&1 || ${pkgs.docker}/bin/docker volume create freshrss_data

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
