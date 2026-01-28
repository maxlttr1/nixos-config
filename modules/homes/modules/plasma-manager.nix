{ config, ... }:

let
  # wallpaper = ../../../wallpapers/wallpaper.jpg;
  wallpaperSlideShow = {
    path = "/home/"${config.users.mainUsername}"/nixos-config/wallpapers";
    interval = 86400;
  };
  font = {
    family = "Mononoki Nerd Font Mono";
    pointSize = 10;
  };
in

{
  programs.plasma = {
    enable = true;
    workspace = {
      cursor = {
        theme = "Breeze_Light";
        #size = 32;
      };
      theme = "breeze";
      colorScheme = "BreezeDark";
      #lookAndFeel = "org.kde.breezedark.desktop";
      iconTheme = "Papirus-Dark";
      windowDecorations = {
        library = "org.kde.kwin.default";
        theme = "Breeze";
      };
      #inherit wallpaper;
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
        "Switch to Desktop 1" = "Meta+&";
        "Switch to Desktop 2" = "Meta+É";
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
}
