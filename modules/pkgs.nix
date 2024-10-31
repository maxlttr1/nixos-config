{ pkgs, ... }:

{
  # Flatpaks
  services.flatpak.packages = [
    "co.logonoff.awakeonlan"
    "com.usebottles.bottles"
    "com.gitlab.davem.ClamTk"
    "com.discordapp.Discord"
    "org.mozilla.firefox"
    "com.github.tchx84.Flatseal"
    "io.gitlab.librewolf-community"
    "me.proton.Pass"
    "com.protonvpn.www"
    "com.visualstudio.code"
    "org.kde.yakuake"
  ];

  environment.systemPackages = 
    (with pkgs; [
      kdePackages.bluedevil
      bibata-cursors
      google-authenticator
      jetbrains-mono
      papirus-icon-theme
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
