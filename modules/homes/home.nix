{ config, pkgs, ... }:

let
  wallpaper = ../../wallpapers/wallpaper.jpg;
  wallpaperSlideShow = {
    path = ../../wallpapers;
    interval = 86400;
  };
  font = {
    #family = "JetBrains Mono";
    family = "Mononoki Nerd Font Mono";
    pointSize = 10;
  };
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
    #package = pkgs.vscodium;
    profiles.default = {
      extensions = with pkgs.nix-vscode-extensions.vscode-marketplace; [
        # Python
        ms-python.python
        # Nix
        bbenoist.nix
        jnoortheen.nix-ide
        # C/C++
        ms-vscode.cpptools
        ms-vscode.cmake-tools  
        # Javascript
        christian-kohler.npm-intellisense
        robole.javascript-snippets
        christian-kohler.path-intellisense # autocompletes filenames 
        # Java
        vscjava.vscode-java-debug
        vscjava.vscode-java-dependency
        redhat.java
        vscjava.vscode-java-test
        # HTML/CSS and Web
        ecmel.vscode-html-css
        ms-vscode.live-server
        naumovs.color-highlight # Preview colors
        # Language pack
        james-yu.latex-workshop
        yzhang.markdown-all-in-one
        # Docker
        ms-azuretools.vscode-docker
        # Yaml
        redhat.vscode-yaml
        # SQL
        cweijan.vscode-mysql-client2
        # Git
        vivaxy.vscode-conventional-commits
        eamodio.gitlens
        github.vscode-github-actions
        # Utilities
        kisstkondoros.vscode-gutter-preview # Image preview
        ms-vsliveshare.vsliveshare
        pflannery.vscode-versionlens # Show latest versions
        formulahendry.auto-rename-tag
        tomoki1207.pdf
        pkief.material-icon-theme
        formulahendry.code-runner
        hediet.vscode-drawio
        pomdtr.excalidraw-editor
        zhuangtongfa.material-theme
        sonarsource.sonarlint-vscode # Linter
      ];
      userSettings = {
        "database-client.autoSync" = true;
        "dtatabase-client.telemetry.usesOnlineServices" = false;
        "editor.fontFamily" = "'Mononoki Nerd Font Mono'";
        "editor.cursorBlinking" = "phase";
        "editor.cursorSmoothCaretAnimation" = "on";
        "explorer.confirmDelete" = false;
        "extensions.ignoreRecommendations" = true;
        "files.autoSave" = "afterDelay";
        "files.autoSaveDelay" = 1000;
        "git.autofetch" = "all";
        "git.confirmSync" = false;
        "git.enableSmartCommit" = true;
        "git.smartCommitChanges" = "all";
        "gitlens.telemetry.enabled" = false;
        "redhat.telemetry.enabled" = false;
        "telemetry.enableTelemetry" = false;
        "telemetry.feedback.enabled" = false;
        "telemetry.telemetryLevel" = "off";
        "window.titleBarStyle" = "custom";
        "workbench.colorTheme" = "One Dark Pro Night Flat";
        "workbench.iconTheme" = "material-icon-theme";
        "workbench.startupEditor" = "none";
        "typescript.suggest.paths" = false; # To use Path Intellisense completion instead of the default
        "javascript.suggest.paths" = false; # To use Path Intellisense completion instead of the default
        "cmake.options.statusBarVisibility" =  "visible";
      };
    };
  };

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
