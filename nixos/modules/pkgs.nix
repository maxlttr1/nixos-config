{ config, pkgs, ... }:

{
  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  # Enable flatpak
  services.flatpak = {
    enable = true;
    update.auto = {
      enable = true;
      onCalendar = "daily";
    };
    remotes = [{
      name = "flathub-beta"; location = "https://flathub.org/beta-repo/flathub-beta.flatpakrepo";
    }];
  };
 
 # Flatpaks
  services.flatpak.packages = [
    "com.jeffser.Alpaca"
    "co.logonoff.awakeonlan"
    "com.bitwarden.desktop"
    "org.gnome.DejaDup"
    "com.discordapp.Discord"
    "org.DolphinEmu.dolphin-emu"
    "com.github.tchx84.Flatseal"
    "nl.hjdskes.gcolor3"
    "io.github.shiftey.Desktop"
    "org.gnupg.GPA"
    "com.heroicgameslauncher.hgl"
    "org.libreoffice.LibreOffice"
    "io.gitlab.librewolf-community"
    "com.moonlight_stream.Moonlight"
    "md.obsidian.Obsidian"
    "com.github.marhkb.Pods"
    "com.protonvpn.www"
    "org.ryujinx.Ryujinx"
    "org.signal.Signal"
    "com.valvesoftware.Steam"
    "me.kozec.syncthingtk"
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
    tree
    unzip
    vkbasalt
    wget
  ];
}
