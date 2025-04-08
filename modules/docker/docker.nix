{ settings, ... }:

{
  virtualisation.docker = {
    enable = true;
    rootless = {
      enable = true;
      setSocketVariable = true;
    };
  };
  users.extraGroups.docker.members = ["${settings.username}"];

  #Docker can now be rootlessly enabled with: systemctl --user enable --now docker
  # Check status: systemctl --user status docker
}
