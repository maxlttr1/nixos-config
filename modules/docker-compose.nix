{ pkgs, ... }:

{
  virtualisation.arion = {
    backend = "docker";
    projects = {
        "db".settings.services."db".service = {
            image = "portainer/portainer-ce:2.21.5";
            container_name = "portainer";
            ports = {
                "8000" = "8000"; 
                "9443" = "9443";
            };
            volumes = {
                "/var/run/docker.sock"="/var/run/docker.sock";
                "portainer_data"="/data";
            };
            restart = "always";
        };
    };
  };
}