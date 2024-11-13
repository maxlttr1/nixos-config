{
  virtualisation.oci-containers = {
    backend = "docker";
    containers = {
      jellyfin = {
        autoStart = true;
        hostname = "jellyfin";
        image = "lscr.io/linuxserver/jellyfin:latest";
        environment = {
          PUID="1000";
          PGID="1000";
          TZ="Etc/UTC";
        };
        volumes = [
          "/home/maxlttr/.docker/jellyfin/library:/config"
          "/home/maxlttr/Videos:/data/tvshows"
          "/home/maxlttr/Videos:/data/movies"
        ];
        ports = [
          "8096:8096"
        ];
      };
    };
  };
}
