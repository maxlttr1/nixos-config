{ settings, ... }:

{
  virtualisation.docker = {
    enable = true;
    /*rootless = {
      enable = true;
      setSocketVariable = true;
    };*/
    #daemon.settings.live-restore = false; # Allow dockerd to be restarted without affecting running container. This option is incompatible with docker swarm.
  };
  #users.extraGroups.docker.members = ["${settings.username}"];
  users.users.${settings.username}.extraGroups = [ "docker" ];


  #Docker can now be rootlessly enabled with: systemctl --user enable --now docker
  # Check status: systemctl --user status docker
}
