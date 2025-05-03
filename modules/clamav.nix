{
  services.clamav.daemon = {
    enable = true;
    settings = {
      "MaxThreads 2"
    };
  };
  services.clamav.updater.enable = true;
  services.clamav.scanner = {
    enable = true;
    interval = "*-*-* 18:00:00";
    scanDirectories = [
      "/home"
      "/tmp"
      "/etc"
      "/var/lib"
      "/var/tmp"
      "/usr"
      "/nix"
    ];
  };
}