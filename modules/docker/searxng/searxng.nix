# Auto-generated using compose2nix v0.3.1.
{ pkgs, lib, config, ... }:

{
  # Runtime
  virtualisation.docker = {
    enable = true;
    autoPrune.enable = true;
  };
  virtualisation.oci-containers.backend = "docker";

  # Containers
  virtualisation.oci-containers.containers."gluetun-searxng" = {
    image = "qmcgaw/gluetun";
    environment = {
      "VPN_SERVICE_PROVIDER" = "custom";
      "VPN_TYPE" = "wireguard";
    };
    environmentFiles = [ config.sops.secrets."vpn.env".path ];
    ports = [
      "808:8080/tcp"
    ];
    labels = {
      "traefik.enable" = "true";
      "traefik.http.routers.search-https.entrypoints" = "websecure";
      "traefik.http.routers.search-https.rule" = "Host(`search.maxlttr7.duckdns.org`)";
      "traefik.http.routers.search-https.tls" = "true";
      "traefik.http.routers.search-https.tls.certresolver" = "myresolver";
      "traefik.http.services.search-https.loadbalancer.server.port" = "8080";
    };
    log-driver = "journald";
    extraOptions = [
      "--cap-add=NET_ADMIN"
      "--device=/dev/net/tun:/dev/net/tun:rwm"
      "--network-alias=gluetun-searxng"
      "--network=proxy"
    ];
  };
  systemd.services."docker-gluetun-searxng" = {
    serviceConfig = {
      Restart = lib.mkOverride 90 "always";
      RestartMaxDelaySec = lib.mkOverride 90 "1m";
      RestartSec = lib.mkOverride 90 "100ms";
      RestartSteps = lib.mkOverride 90 9;
    };
    partOf = [
      "docker-compose-searxng-stack-root.target"
    ];
    wantedBy = [
      "docker-compose-searxng-stack-root.target"
    ];
  };
  virtualisation.oci-containers.containers."searxng-stack-searxng" = {
    image = "searxng/searxng:latest";
    environment = {
      "SEARXNG_BASE_URL" = "https://search.maxlttr7.duckdns.org/";
      "UWSGI_THREADS" = "8";
      "UWSGI_WORKERS" = "8";
    };
    volumes = [
      "/home/maxlttr/docker/searxng/searxng-data:/etc/searxng:rw"
    ];
    dependsOn = [
      "gluetun-searxng"
    ];
    log-driver = "journald";
    extraOptions = [
      "--cap-add=CHOWN"
      "--cap-add=SETGID"
      "--cap-add=SETUID"
      "--network=container:gluetun-searxng"
    ];
  };
  systemd.services."docker-searxng-stack-searxng" = {
    serviceConfig = {
      Restart = lib.mkOverride 90 "always";
      RestartMaxDelaySec = lib.mkOverride 90 "1m";
      RestartSec = lib.mkOverride 90 "100ms";
      RestartSteps = lib.mkOverride 90 9;
    };
    partOf = [
      "docker-compose-searxng-stack-root.target"
    ];
    wantedBy = [
      "docker-compose-searxng-stack-root.target"
    ];
  };

  # Root service
  # When started, this will automatically create all resources and start
  # the containers. When stopped, this will teardown all resources.
  systemd.targets."docker-compose-searxng-stack-root" = {
    unitConfig = {
      Description = "Root target generated by compose2nix.";
    };
    wantedBy = [ "multi-user.target" ];
  };
}
