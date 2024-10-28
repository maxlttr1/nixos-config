{ pkgs, ... }:

{
  programs.steam.enable = true;

  # Flatpaks
  services.flatpak.packages = [
  ];

  environment.systemPackages = 
    (with pkgs; [
    ])
    ++
    (with pkgs.unstable; [
      goverlay
      mangohud
    ]);
}
