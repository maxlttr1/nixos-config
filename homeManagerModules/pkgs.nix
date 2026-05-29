{
  config,
  lib,
  pkgs,
  ...
}:

{
  options.custom.pkgs.enable = lib.mkEnableOption "additional packages";

  config = lib.mkIf config.custom.pkgs.enable {
    home.packages = with pkgs; [
      # age
      # at
      bleachbit
      # cron
      curl
      direnv
      element-desktop
      # eza
      fastfetch
      fd
      fzf
      htop
      # lf
      magic-wormhole
      ncdu
      # powertop
      ripgrep-all
      unstable.signal-desktop # Unverified on flathub
      tldr
      typst
      typst-live
      # unp
      # unrar
      # vim
      vlc
      # wget
    ];

    services.flatpak = {
      update.auto = {
        enable = true;
        onCalendar = "weekly";
      };
      packages = [
        "com.google.Chrome"
        "io.github.finefindus.Hieroglyphic"
        "org.libreoffice.LibreOffice"
        "io.gitlab.librewolf-community"
        "io.github.mhogomchungu.media-downloader"
        "com.github.jeromerobert.pdfarranger"
        "com.valvesoftware.Steam"
        "org.mozilla.Thunderbird"
        "org.torproject.torbrowser-launcher"
        "dev.vencord.Vesktop"
      ];
    };
  };
}
