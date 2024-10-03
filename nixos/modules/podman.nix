{
  # Enable containers
  virtualisation.containers.enable = true;  
  virtualisation = {
    podman = {
      enable = true;
      defaultNetwork.settings.dns_enabled = true; 
    };
  };

  environment.systemPackages = with pkgs; [
    dive #look into docker image layers
    docker-compose #start group of containers for dev
    podman-compose #start group of containers for dev
    podman-tui #status of the containers in the terminal
  ];

}
