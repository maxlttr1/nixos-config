{ pkgs, ... }:

{
  programs.steam.enable = true;

  # Flatpaks
  services.flatpak.packages = [
  ];

  environment.systemPackages = 
    (with pkgs; [
      goverlay
      mangohud
    ])
    ++
    (with pkgs.unstable; [
    ]);
}
