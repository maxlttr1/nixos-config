{ pkgs, ... }:

{
  # Enable containers
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
  ];

  virtualisation.oci-containers.backend = "podman";
  virtualisation.oci-containers.containers = {
    container-name = {
      image = "hello-world";
      autoStart = true;
      #ports = [ "127.0.0.1:1234:1234" ];
    };
  };

}
