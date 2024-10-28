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
    "com.valvesoftware.Steam"
    "runtime/org.freedesktop.Platform.VulkanLayer.MangoHud/x86_64/24.08"
    "runtime/org.freedesktop.Platform.VulkanLayer.gamescope/x86_64/24.08"
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
