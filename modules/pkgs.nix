{ pkgs, ... }:

{
  # Flatpaks
  services.flatpak.packages = [
    #"co.logonoff.awakeonlan"
  ];

  environment.systemPackages = 
    (with pkgs; [
      kdePackages.bluedevil #Bluetooth for kde
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
