{
  services.clamav.daemon = {
    enable = true;
    settings = {
      MaxThreads = 1;
    };
  };
  services.clamav.updater = {
    enable = true;
    frequency = 1; # Number of database checks per day
    interval = "weekly";
  };
  services.clamav.scanner = {
    enable = true;
    interval = "weekly"; 
    scanDirectories = [
      "/home"
      "/root"
      "/opt"
      "/tmp"
      "/etc"
      "/var"
      "/usr"
      "/nix"
    ];
  };
}