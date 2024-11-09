{ pkgs, ... }:

{
  # Flatpaks
  services.flatpak.packages = [
    "co.logonoff.awakeonlan"
    "io.gitlab.librewolf-community"
    "org.mozilla.firefox"
    "io.github.milkshiift.GoofCord"
    "com.moonlight_stream.Moonlight"
    "com.protonvpn.www"
    "com.visualstudio.code"
  ];

  environment.systemPackages = 
    (with pkgs; [
      kdePackages.bluedevil
      bibata-cursors
      google-authenticator
      jetbrains-mono
      papirus-icon-theme
      kdePackages.yakuake
    ])
    ++
    (with pkgs.unstable; [
    ]);
 
  services.flatpak = {
    enable = true;
    update = {
      auto = {
        enable = true;
        onCalendar = "daily";
      };
    };
  };
}
