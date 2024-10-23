{ pkgs, ... }:

{

  services.ollama = {
    enable = true;
    acceleration = false;
    #acceleration = "rocm"; #supported by most modern AMD GPUs
    #acceleration = "cuda"; #supported by most modern NVIDIA GPUs
  };

  programs.steam.enable = true;

  # Flatpaks
  services.flatpak.packages = [
    "co.logonoff.awakeonlan"
    "com.discordapp.Discord"
    "com.github.tchx84.Flatseal"
    "me.proton.Pass"
  ];
  
  nixpkgs.config.allowUnfree = true;

  environment.systemPackages = with pkgs; [
    kdePackages.alpaka
    bibata-cursors
    bottles
    curl
    deja-dup
    fastfetch
    kdePackages.filelight
    git
    kdePackages.isoimagewriter
    jetbrains-mono
    jdk #Java LTS
    kdePackages.kleopatra
    kdePackages.kcolorpicker
    libreoffice-qt-fresh
    librewolf
    mangohud
    papirus-icon-theme
    pods
    protonvpn-gui
    python312
    python312Packages.pip
    python312Packages.pytest
    kdePackages.qtwebengine
    syncthingtray
    tree
    universal-android-debloater
    unzip
    vscode
    kdePackages.yakuake
    wget
  ];
  
  # Open ports in the firewall for kde connect
  networking.firewall = rec {
    allowedTCPPortRanges = [ { from = 1714; to = 1764; } ];
    allowedUDPPortRanges = allowedTCPPortRanges;
  };
 
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
