{ config, pkgs, ... }:

let
  wallpaper = ../../wallpaper.jpg;
in

{
  # Home Manager needs a bit of information about you and the
  # paths it should manage.
  /*home.username = "${settings.username}";
  home.homeDirectory = "/home/${settings.username}";

  # Packages that should be installed to the user profile.
  home.packages = [
  ];*/

  programs.vscode = {
    enable = true;
    package = pkgs.vscodium;
    extensions = with pkgs.vscode-marketplace; [
      # Python
      ms-python.python
      ms-python.black-formatter
      # Nix
      bbenoist.nix
      jnoortheen.nix-ide
      # Language pack
      franneck94.vscode-c-cpp-dev-extension-pack # C/C++ pack
      gydunhn.javascript-essentials # Javascript pack
      edwinkofler.vscode-hyperupcall-pack-java # Java pack
      ecmel.vscode-html-css # HTML CSS
      redhat.ansible
      james-yu.latex-workshop
      yzhang.markdown-all-in-one
      # Utilities
      formulahendry.auto-rename-tag
      esbenp.prettier-vscode
      ms-azuretools.vscode-docker
      redhat.vscode-yaml
      tomoki1207.pdf
      pkief.material-icon-theme
      cweijan.vscode-mysql-client2
      formulahendry.code-runner
      ms-vscode.live-server
      usernamehw.errorlens
      oderwat.indent-rainbow
      hediet.vscode-drawio
      naumovs.color-highlight
      pomdtr.excalidraw-editor
      vivaxy.vscode-conventional-commits
    ];
  };

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
      temperature.day = 5000;
      temperature.night = 3000;
    };
    krunner.position = "center";
    spectacle.shortcuts.captureRectangularRegion = "Meta+Shift+S";
    kwin.virtualDesktops = {
      names = [
        "1"
        "2"
        "3"
      ];
      number = 3;
    };
    panels = [
      # Windows-like panel at the bottom
      {
        location = "bottom";
        floating = true;
        opacity = "adaptive";
        hiding = "none";
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
          "org.kde.plasma.stickynote"
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
