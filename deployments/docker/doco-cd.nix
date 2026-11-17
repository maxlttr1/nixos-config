{
  virtualisation.oci-containers = {
    backend = "docker";
    containers = {
      doco-cd = {
        image = "ghcr.io/kimdre/doco-cd:latest";
        autoStart = true;
        environment = {
          TZ = "Europe/Berlin";
          GIT_AUTH_DOMAINS = "- domains: [github.com]";
          POLL_CONFIG = ''
            - url: https://forgejo.maxlttr.fr/maxlttr/nixos-config.git
              reference: master
              interval: 180
          '';
        };
        volumes = [
          "/var/run/docker.sock:/var/run/docker.sock"
          "doco-cd/data:/data"
        ];
        extraOptions = [
          "--cap-drop=ALL"
          # "--health-start-period=15s"
          # "--health-interval=30s"
          # "--health-timeout=5s"
          # "--health-retries=3"
        ];
        restartPolicy = "unless-stopped";
      };
    };
  };
}
