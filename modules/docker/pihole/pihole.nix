# Auto-generated using compose2nix v0.3.1.
{ pkgs, lib, ... }:

{
  # Runtime
  virtualisation.docker = {
    enable = true;
    autoPrune.enable = true;
  };
  virtualisation.oci-containers.backend = "docker";

  # Containers
  virtualisation.oci-containers.containers."pihole" = {
    image = "pihole/pihole:latest";
    environment = {
      "DNSSEC" = "true";
      "PIHOLE_DNS_" = "9.9.9.9";
      "TZ" = "Europe/Paris";
    };
    volumes = [
      "/home/maxlttr/docker/pi-hole/etc-dnsmasq.d:/etc/dnsmasq.d:rw"
      "/home/maxlttr/docker/pi-hole/etc-pihole:/etc/pihole:rw"
    ];
    ports = [
      "53:53/tcp"
      "53:53/udp"
      "8088:80/tcp"
    ];
    log-driver = "journald";
    extraOptions = [
      "--cap-add=NET_ADMIN"
      "--network-alias=pihole"
      "--network=pi-hole_default"
    ];
  };
  systemd.services."docker-pihole" = {
    serviceConfig = {
      Restart = lib.mkOverride 90 "always";
      RestartMaxDelaySec = lib.mkOverride 90 "1m";
      RestartSec = lib.mkOverride 90 "100ms";
      RestartSteps = lib.mkOverride 90 9;
    };
    after = [
      "docker-network-pi-hole_default.service"
    ];
    requires = [
      "docker-network-pi-hole_default.service"
    ];
    partOf = [
      "docker-compose-pi-hole-root.target"
    ];
    wantedBy = [
      "docker-compose-pi-hole-root.target"
    ];
  };

  # Networks
  systemd.services."docker-network-pi-hole_default" = {
    path = [ pkgs.docker ];
    serviceConfig = {
      Type = "oneshot";
      RemainAfterExit = true;
      ExecStop = "docker network rm -f pi-hole_default";
    };
    script = ''
      docker network inspect pi-hole_default || docker network create pi-hole_default
    '';
    partOf = [ "docker-compose-pi-hole-root.target" ];
    wantedBy = [ "docker-compose-pi-hole-root.target" ];
  };

  # Root service
  # When started, this will automatically create all resources and start
  # the containers. When stopped, this will teardown all resources.
  systemd.targets."docker-compose-pi-hole-root" = {
    unitConfig = {
      Description = "Root target generated by compose2nix.";
    };
    wantedBy = [ "multi-user.target" ];
  };
}
