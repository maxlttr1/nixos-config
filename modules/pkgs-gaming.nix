{ pkgs, ... }:

{
  #programs = {
  #  gamescope = {
   #   enable = true;
  #    capSysNice = true;
  #  };
  #  steam = {
  #    enable = true;
  #    #gamescopeSession.enable = true;
  #  };
  #};

  # Flatpaks
  services.flatpak.packages = [
    com.valvesoftware.Steam
    org.freedesktop.Platform.VulkanLayer.MangoHud
    org.freedesktop.Platform.VulkanLayer.gamescope
    
  ];

  environment.systemPackages = 
    (with pkgs; [
      #goverlay
      #lutris
      #mangohud
    ])
    ++
    (with pkgs.unstable; [
    ]);
}
