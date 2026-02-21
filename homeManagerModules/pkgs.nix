{ config, lib, pkgs, ... }:

{
  options.custom.pkgs.enable = lib.mkEnableOption "additional packages";

  config = lib.mkIf config.custom.pkgs.enable {
    home.packages = with pkgs.stable; [
      bleachbit
      direnv
      papirus-icon-theme
      typst
      typst-live
      vlc
    ];

    services.flatpak = {
      update.auto = {
        enable = true;
        onCalendar = "daily";
      };
      packages = [
        "com.google.Chrome"
        "io.github.finefindus.Hieroglyphic"
        "org.libreoffice.LibreOffice"
        "io.gitlab.librewolf-community"
        "io.github.mhogomchungu.media-downloader"
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
