{ config, lib, settings, ... }:

let
  # wallpaper = ../../../wallpapers/wallpaper.jpg;
  wallpaperSlideShow = {
    path = "/home/${settings.username}/Documents/nixos-config/wallpapers";
    interval = 86400;
  };
  font = {
    family = "Mononoki Nerd Font Mono";
    pointSize = 10;
  };
in

/*
~/.config/plasmarc - Plasma shell configuration
~/.config/kglobalshortcutsrc - Keyboard shortcuts
~/.config/kdeglobals - Global KDE settings
~/.local/share/applications/ - Custom app shortcuts
~/.local/share/kxmlgui5/ - UI configurations
*/

{
  options.plasmaManager.enable = lib.mkEnableOption "KDE Plasma manager";


  config = lib.mkIf config.plasmaManager.enable {
    home.file.".config/mimeapps.list".text = ''
      [Added Associations]
      application/json=org.kde.kwrite.desktop;
      application/pdf=io.gitlab.librewolf-community.desktop;
      application/x-docbook+xml=org.kde.kwrite.desktop;
      application/x-yaml=org.kde.kwrite.desktop;
      text/markdown=org.kde.kwrite.desktop;
      text/plain=org.kde.kwrite.desktop;
      text/x-cmake=org.kde.kwrite.desktop;
      x-scheme-handler/http=io.gitlab.librewolf-community.desktop;
      x-scheme-handler/https=io.gitlab.librewolf-community.desktop;

      [Default Applications]
      application/json=org.kde.kwrite.desktop;
      application/pdf=io.gitlab.librewolf-community.desktop;
      application/x-docbook+xml=org.kde.kwrite.desktop;
      application/x-yaml=org.kde.kwrite.desktop;
      text/markdown=org.kde.kwrite.desktop;
      text/plain=org.kde.kwrite.desktop;
      text/x-cmake=org.kde.kwrite.desktop;
      x-scheme-handler/http=io.gitlab.librewolf-community.desktop;
      x-scheme-handler/https=io.gitlab.librewolf-community.desktop;
    '';

    programs.plasma = {
      enable = true;
      workspace = {
        cursor = {
          theme = "Breeze_Light";
          #size = 32;
        };
        theme = "breeze";
        colorScheme = "BreezeDark";
        iconTheme = "Papirus-Dark";
        windowDecorations = {
          library = "org.kde.kwin.default";
          theme = "Breeze";
        };
        inherit wallpaperSlideShow;
      };
      immutableByDefault = false;
      fonts = {
        fixedWidth = font;
        general = font;
        menu = font;
        small = {
          family = font.family;
          pointSize = 8;
        };
        toolbar = font;
        windowTitle = font;
      };
      input.keyboard.numlockOnStartup = "on";
      kscreenlocker = {
        appearance = {
          inherit wallpaperSlideShow;
          showMediaControls = false;
        };
      };
      kwin.nightLight = {
        enable = true;
        location.latitude = "46.04";
        location.longitude = "0.69";
        mode = "location";
        temperature.day = 4500;
        temperature.night = 2500;
      };
      krunner.position = "center";
      shortcuts = {
        kwin = {
		  "Window Maximize" = "Meta+F";
          "Switch to Desktop 1" = "Meta+&";
          "Switch to Desktop 2" = "Meàta+É";
          "Switch to Desktop 3" = "Meta+\"";
          "Switch to Desktop 4" = "Meta+\'";
        };
      };

      kwin.virtualDesktops = {
        names = [
          "1"
          "2"
          "3"
          "4"
        ];
        number = 4;
      };
      panels = [
        {
          location = "bottom";
          floating = true;
          opacity = "adaptive";
          hiding = "none";
          #height = 42;
          widgets = [
            {
              name = "org.kde.plasma.kickoff";
              config = {
                General = {
                  icon = "nix-snowflake-white";
                  alphaSort = true;
                };
              };
            }
            {
              iconTasks = {
                launchers = [ ];
              };
            }
            "org.kde.plasma.panelspacer"
            "org.kde.plasma.pager"
            "org.kde.plasma.panelspacer"
            "org.kde.plasma.marginsseparator"
            "org.kde.plasma.notes"
            {
              systemTray.items = {
                shown = [
                  "org.kde.plasma.notifications"
                  "org.kde.plasma.battery"
                  "org.kde.plasma.brightness"
                  "org.kde.plasma.volume"
                  "org.kde.plasma.bluetooth"
                  "org.kde.plasma.networkmanagement"
                  "org.kde.plasma.kdeconnect"
                ];
                hidden = [ ];
              };
            }
            {
              digitalClock = {
                calendar.firstDayOfWeek = "monday";
                time.format = "24h";
              };
            }
          ];
        }
      ];
    };
  };
}
