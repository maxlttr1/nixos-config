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

  # Flatpaks
  services.flatpak.packages = [
  ];

  environment.systemPackages = 
    (with pkgs; [
      #lutris
      #mangohud
    ])
    ++
    (with pkgs.unstable; [
    ]);
}
