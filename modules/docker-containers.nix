{ pkgs, ...}:

{
  hardware.nvidia-container-toolkit.enable = true;

  virtualisation.oci-containers = {
    backend = "docker";
    containers = {
      jellyfin = {
        autoStart = false;
        hostname = "jellyfin";
        image = "lscr.io/linuxserver/jellyfin:latest";
        environment = {
          PUID="1000";
          PGID="1000";
          TZ="Etc/UTC";
        };
        volumes = [
          "/home/maxlttr/.docker/jellyfin/library:/config"
          #"/home/maxlttr/Syncthing/:/data/tvshows"
          "/home/maxlttr/Syncthing/movies:/data/movies"
        ];
        ports = [
          "8096:8096"
        ];
        cmd = [
          "--device=/dev/dri:/dev/dri"
        ];
      };
      portainer = {
        hostname = "portainer";
        autoStart = false;
        image = "portainer/portainer-ce:2.21.5";
        ports = [
          "8000:8000"
          "9443:9443"
        ];
        volumes = [
          "/var/run/docker.sock:/var/run/docker.sock"
          "portainer_data:/data"
        ];
      };
      windows = {
        hostname = "windows";
        autoStart = false;
        image = "dockurr/windows";
        environment = {
          #VERSION = "11";
          VERSION = "https://example.com/win.iso";
          DISK_SIZE = "64G";
          RAM_SIZE =  "8G";
          CPU_CORES = "4";
        ports = [
          "8006:8006"
          "3389:3389/tcp"
          "3389:3389/udp"
        ];
        cmd = [
          "--device=/dev/kvm"
          "--device=/dev/net/tun"
          "--cap-add=NET_ADMIN"
        ];
        }
      };
    };
  };
}
