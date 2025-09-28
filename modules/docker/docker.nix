{ settings, ... }:

{
  virtualisation.docker = {
    enable = true;
    /*rootless = {
      enable = true;
      setSocketVariable = true;
    };*/
    daemon.settings.live-restore = false;
    /*live-restore allows Docker to keep containers running 
    even if the Docker daemon restarts. This feature is not compatible
    with Docker Swarm, which requires full control over container lifecycle.*/
  };
  #users.extraGroups.docker.members = ["${settings.username}"];
  users.users.${settings.username}.extraGroups = [ "docker" ];


  #Docker can now be rootlessly enabled with: systemctl --user enable --now docker
  # Check status: systemctl --user status docker
}
