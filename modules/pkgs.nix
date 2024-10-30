{ pkgs, ... }:

{
  
  # Flatpaks
  services.flatpak.packages = [
    "co.logonoff.awakeonlan"
    "com.discordapp.Discord"
    "com.github.tchx84.Flatseal"
    "me.proton.Pass"
  ];

  environment.systemPackages = 
    (with pkgs; [
      kdePackages.bluedevil
      bibata-cursors
      bottles
      firefox
      google-authenticator
      jetbrains-mono
      kdePackages.kleopatra
      librewolf
      papirus-icon-theme
      protonplusde
      protonvpn-gui
      vscode
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
