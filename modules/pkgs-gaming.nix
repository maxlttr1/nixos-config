{ pkgs, ... }:

{
  /*programs = {
    gamescope = {
      enable = true;
      capSysNice = true;
    };
    steam = {
      enable = true;
      gamescopeSession.enable = true;
    };
  };*/

  # Flatpaks
  services.flatpak.packages = [
    #"com.heroicgameslauncher.hgl"
    #"net.davidotek.pupgui2"
    "com.github.Matoking.protontricks" # flatpak override --user --filesystem=/path/to/other/Steam/Library com.github.Matoking.protontricks
    "com.valvesoftware.Steam"
  ];

  environment.systemPackages = 
    (with pkgs; [
    ])
    ++
    (with pkgs.alternative; [
      steam-devices-udev-rules
    ]);
}
