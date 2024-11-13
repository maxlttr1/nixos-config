{ pkgs, ... }:

{
 /*# Enable containers
  virtualisation.containers.enable = true;  
  virtualisation = {
    podman = {
      enable = true;

      # Create a `docker` alias for podman, to use it as a drop-in replacement
      dockerCompat = true;
      
      # Required for containers under podman-compose to be able to talk to each other.
      defaultNetwork.settings.dns_enabled = true; 
    };
  };

  environment.systemPackages = with pkgs; [
    dive #look into docker image layers
    docker-compose #start group of containers for dev
    podman-compose #start group of containers for dev
    podman-tui #status of the containers in the terminal
  ];*/

  virtualisation.docker.enable = true;

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
