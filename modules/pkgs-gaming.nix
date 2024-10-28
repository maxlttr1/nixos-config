{ pkgs, ... }:

{
  programs = {
    gamescope = {
      enable = true;
      capSysNice = true;
    };
    steam = {
      enable = true;
      gamescopeSession.enable = true;
    };
  };

  hardware.xone.enable = true; # support for the xbox controller USB dongle

  # Flatpaks
  services.flatpak.packages = [
  ];

  environment.systemPackages = 
    (with pkgs; [
      goverlay
      lutris
      mangohud
    ])
    ++
    (with pkgs.unstable; [
    ]);
}
