{ pkgs, ... }:

{
  programs.steam.enable = true;

  # Flatpaks
  services.flatpak.packages = [
  ];

  environment.systemPackages = 
    (with pkgs; [
      gamescope
      goverlay
      lutris
      mangohud
    ])
    ++
    (with pkgs.unstable; [
    ]);
}
