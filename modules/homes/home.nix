{ config, pkgs, ... }:

let
  wallpaper = ../../wallpaper.jpg;
in

{
  # Home Manager needs a bit of information about you and the
  # paths it should manage.
  home.username = "maxlttr";
  home.homeDirectory = "/home/maxlttr";

  # Packages that should be installed to the user profile.
  home.packages = [
  ];

  programs.plasma = {
    enable = true;
    workspace = {
      #clickItemTo = "open"; # If you liked the click-to-open default from plasma 5
      cursor = {
        theme = "Bibata-Modern-Ice";
        size = 32;
      };
      theme = "breeze-dark";
      colorScheme = "BreezeDark";
      lookAndFeel = "org.kde.breezedark.desktop";
      iconTheme = "Papirus-Dark";
      inherit wallpaper;
    };
    immutableByDefault = true;
    fonts = {
      general = {
        family = "JetBrains Mono";
        pointSize = 10;
      };
    };
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
    kscreenlocker.appearance = {
      inherit wallpaper;
      showMediaControls = false;
    };
    kwin.nightLight = {
      enable = true;
      location.latitude = "46.04";
      location.longitude = "0.69";
      mode = "location";
      temperature.day = 5500;
      temperature.night = 3500;
    };
    krunner.position = "center";
    spectacle.shortcuts.captureRectangularRegion = "Meta+Shift+S";
    panels = [
      # Windows-like panel at the bottom
      {
        location = "bottom";
        floating = true;
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
          "org.kde.plasma.pager"
          {
            iconTasks = {
              launchers = [
              ];
            };
          }
          "org.kde.plasma.marginsseparator"
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
    powerdevil = {
      AC = {
        powerButtonAction = "sleep";
        whenLaptopLidClosed = "sleep";
        autoSuspend = {
          action = "sleep";
          idleTimeout = 900;
        };
      };
      battery = {
        powerButtonAction = "sleep";
        whenSleepingEnter = "standbyThenHibernate";
        whenLaptopLidClosed = "sleep";
        autoSuspend = {
          action = "sleep";
          idleTimeout = 300;
        };
      };
      lowBattery = {
        powerButtonAction = "sleep";
        whenLaptopLidClosed = "sleep";
        autoSuspend = {
          action = "sleep";
          idleTimeout = 120;
        };
      };
    };
  };

  programs.git = {
    enable = true;
    userEmail = "maxime.lettier@protonmail.com";
    userName = "Maxime";
  };

  # This value determines the Home Manager release that your
  # configuration is compatible with. This helps avoid breakage
  # when a new Home Manager release introduces backwards
  # incompatible changes.
  #
  # You can update Home Manager without changing this value. See
  # the Home Manager release notes for a list of state version
  # changes in each release.
  home.stateVersion = "24.05";

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;
}
