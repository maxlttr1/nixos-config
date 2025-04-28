{
  system.autoUpgrade = {
    enable = true;
    flake = inputs.self.outPath;
    flags = [
      "--update-input"
      "nixpkgs-main"
      "-L" # Show logs
    ];
    dates = "Sun 02:00";  # Every Monday at 2 AM
    randomizedDelaySec = "30min";
    persistent = true;
    operation = "switch"; # Or "boot"
    allowReboot = true;
    rebootWindow = {
      lower = "01:00";
      upper = "05:00";
    };
  };
}
