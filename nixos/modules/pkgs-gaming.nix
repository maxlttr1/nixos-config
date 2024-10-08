{ pkgs, ... }:

{
  services.flatpak.packages = [
    "com.heroicgameslauncher.hgl"
    "net.lutris.Lutris"
    "org.freedesktop.Platform.VulkanLayer.MangoHud"
    "com.moonlight_stream.Moonlight"
    "com.vysp3r.ProtonPlus"
    "org.libretro.RetroArch"
    "com.valvesoftware.Steam"
  ];
 
  environment.systemPackages = with pkgs; [
    vkbasalt
  ];
}
