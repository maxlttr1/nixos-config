{ pkgs, ... }:

{
  # Flatpaks
  services.flatpak.packages = [
    "co.logonoff.awakeonlan"
    "com.usebottles.bottles"
    "com.discordapp.Discord"
    "com.github.tchx84.Flatseal"
    "com.protonvpn.www"
    "com.visualstudio.code"
    "org.kde.yakuake"
    "io.github.zen_browser.zen"
  ];

  environment.systemPackages = 
    (with pkgs; [
      kdePackages.bluedevil
      bibata-cursors
      google-authenticator
      jetbrains-mono
      papirus-icon-theme
      scrcpy
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
