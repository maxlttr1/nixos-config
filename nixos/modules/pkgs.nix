{ config, pkgs, ... }:

{
  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  # Enable flatpak
  services.flatpak = {
    enable = true;
    update = {
      onActivation = true;
      auto = {
        enable = true;
        onCalendar = "daily";
      };
    };
    remotes = [{
      name = "flathub-beta"; location = "https://flathub.org/beta-repo/flathub-beta.flatpakrepo";
    }];
  };
 
 # Flatpaks
  services.flatpak.packages = [
    "com.jeffser.Alpaca"
    "com.bitwarden.desktop"
    "com.discordapp.Discord"
    "org.DolphinEmu.dolphin-emu"
    "com.github.tchx84.Flatseal"
    "nl.hjdskes.gcolor3"
    "com.github.Murmele.Gittyup"
    "org.gnupg.GPA"
    "org.libreoffice.LibreOffice"
    "io.gitlab.librewolf-community"   
    "net.lutris.Lutris"
    "md.obsidian.Obsidian"
    "com.github.marhkb.Pods"
    "com.protonvpn.www"
    "org.signal.Signal"
    "com.vscodium.codium"
  ];

  programs.gamemode.enable = true;
  programs.gamescope = {
    enable = true;
    capSysNice = true;
  };

  hardware.xone.enable = true; # support for the xbox controller USB dongle  

  environment.systemPackages = with pkgs; [
    curl
    dive #look into docker image layers
    docker-compose #start group of containers for dev
    fastfetch
    mangohud
    podman-compose #start group of containers for dev
    podman-tui #status of the containers in the terminal
    protonup-qt
    python312
    python312Packages.pip
    python312Packages.pytest
    unzip
    vkbasalt
    wget
  ];
}
