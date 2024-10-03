{ pkgs, ... }:

{
  services.flatpak.packages = [
    "com.heroicgameslauncher.hgl"
    "org.libretro.RetroArch"
    "com.valvesoftware.Steam"
  ];
 
  environment.systemPackages = with pkgs; [
    mangohud
    protonup-qt
    unzip
    vkbasalt
  ];
}
