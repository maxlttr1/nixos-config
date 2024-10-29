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
      kdePackages.alpaka
      kdePackages.bluedevil
      bibata-cursors
      bottles
      corectrl
      deja-dup
      firefox
      kdePackages.filelight
      kdePackages.isoimagewriter
      jetbrains-mono
      kdePackages.kleopatra
      kdePackages.kcolorpicker
      libreoffice-qt-fresh
      librewolf
      mangohud
      papirus-icon-theme
      pods
      protonplus
      protonvpn-gui
      kdePackages.qtwebengine
      syncthingtray
      universal-android-debloater
      ventoy-full
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
