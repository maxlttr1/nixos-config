let
  # wallpaper = ../../../wallpapers/wallpaper.jpg;
  wallpaperSlideShow = {
    path = ../../../wallpapers;
    interval = 86400;
  };
  font = {
    #family = "JetBrains Mono";
    family = "Mononoki Nerd Font Mono";
    pointSize = 10;
  };
in

{
  programs.plasma = {
    enable = true;
    workspace = {
      #clickItemTo = "open"; # If you liked the click-to-open default from plasma 5
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
    /*input.touchpads = [
      {
        enable = true;
        disableWhileTyping = true;
        leftHanded = false;
        middleMouseEmulation = false;
        naturalScroll = true;
        pointerSpeed = 0;
        tapToClick = true;
        tapAndDrag = true;
        scrollSpeed = 5;
        name = "Elan Microelectronics Corp. ELAN:ARM-M4";
        productId = "0c6c";
        vendorId = "04f3";
      }
    ];*/
    kscreenlocker = {
      appearance = {
        #inherit wallpaper;
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
    spectacle.shortcuts.captureRectangularRegion = "Meta+Shift+S";
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
      # Windows-like panel at the bottom
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
              launchers = [
              ];
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
              hidden = [
              ];
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