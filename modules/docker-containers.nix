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
    };
  };
}
