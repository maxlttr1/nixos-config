{ pkgs, ... }:

{
  services.flatpak.packages = [
    "com.heroicgameslauncher.hgl"
    "com.moonlight_stream.Moonlight"
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
