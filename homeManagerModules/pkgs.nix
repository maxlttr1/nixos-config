{ config, lib, pkgs, ... }:

{
  options.pkgs.enable = lib.mkEnableOption "additional packages";

  config = lib.mkIf config.pkgs.enable {
    home.packages = with pkgs.stable; [
      # bottles
      # deja-dup
      direnv
      ffmpeg
      # gnupg
      # grex # Command-line tool for generating regular expressions from user-provided test cases
      # mask # A CLI task runner defined by a simple markdown file
      # moreutils # to get vipe
      papirus-icon-theme
      # protonvpn-gui
      /*(rstudioWrapper.override {
        packages = with rPackages; [ FactoMineR ];
      })*/

      # texliveFull
      typst
      typst-live
      # veracrypt
      vlc
    ];

    services.flatpak = {
      update.auto = {
        enable = true;
        onCalendar = "daily";
      };
      packages = [
        # "org.bleachbit.BleachBit"
        "com.google.Chrome"
        "io.github.finefindus.Hieroglyphic"
        "org.libreoffice.LibreOffice"
        "io.gitlab.librewolf-community"
        "io.github.mhogomchungu.media-downloader"
        # "md.obsidian.Obsidian"
        # "com.obsproject.Studio"
        "com.github.jeromerobert.pdfarranger"
        "org.signal.Signal"
        "com.valvesoftware.Steam"
        "org.mozilla.Thunderbird"
        "org.torproject.torbrowser-launcher"
        "dev.vencord.Vesktop"
      ];
    };
  };
}
