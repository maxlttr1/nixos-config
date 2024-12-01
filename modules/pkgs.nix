{ pkgs, ... }:

{
  # Flatpaks
  services.flatpak.packages = [
    #"co.logonoff.awakeonlan"
  ];

  environment.systemPackages = 
    (with pkgs; [
      kdePackages.bluedevil
      bibata-cursors
      discord
      firefox
      google-authenticator
      jdk #Java LTS
      jetbrains-mono
      librewolf
      #moonlight-qt
      #linux-firmware
      papirus-icon-theme
      protonvpn-gui
      python312Full
      python312Packages.matplotlib
      python312Packages.numpy
      python312Packages.pip
      python312Packages.pytest
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
