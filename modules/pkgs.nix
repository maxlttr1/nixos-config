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
      curl
      discord
      fastfetch
      firefox
      git
      #google-authenticator
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
      tree
      unzip
      vscode
      wget
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
