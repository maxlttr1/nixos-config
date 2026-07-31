{
  config,
  lib,
  pkgs,
  settings,
  ...
}:

{
  options.custom = {
    gaming = {
      enable = lib.mkEnableOption "Enables gaming packages";
      sunshine = {
        enable = lib.mkEnableOption "Enables Sunshine streaming";
      };
      moonlight = {
        enable = lib.mkEnableOption "Enables Moonlight streaming client";
      };
    };
  };

  config = lib.mkMerge [
    (lib.mkIf config.custom.gaming.sunshine.enable {
      services.sunshine = {
        enable = true;
        autoStart = false;
        capSysAdmin = true; # only needed for Wayland -- omit this when using with Xorg
        openFirewall = true;
      };

      hardware.uinput.enable = true;

      users.users."${settings.username}" = {
        extraGroups = [ "uinput" ];
      };
    })

    (lib.mkIf config.custom.gaming.moonlight.enable {
      environment.systemPackages = with pkgs; [
        moonlight-qt
      ];
    })

    (lib.mkIf config.custom.gaming.enable {
      boot.kernelModules = [ "ntsync" ];

      environment.systemPackages = with pkgs; [
        # DXVK_CONFIG="dxgi.maxFrameRate = 60; d3d9.maxFrameRate = 60" PROTON_LOG=1 MANGOHUD_CONFIG=fps_limit=0,60 WINE_FULLSCREEN_FSR=1 WINE_FULLSCREEN_FSR_STRENGTH=2 mangohud gamemoderun %command%
        mangohud # Shift_R+F12 : Toggle Hud / Shift_L+F1: Cyle between fps limits/ mangohud %command%
      ];

      programs.gamemode = {
        enable = true;
        enableRenice = true;
      };

      hardware.xone.enable = true; # Xbox One controller support

      programs = {
        steam = {
          enable = true;
          remotePlay.openFirewall = true;
          # gamescopeSession.enable = true; # Run a GameScope driven Steam session from your display-manager
          extraCompatPackages = with pkgs; [
            proton-ge-bin
          ];
        };
        /*
          gamescope = {
            enable = true; # gamescope -w 1280 -h 720 -W 1920 -H 1080 -r 70 -f -F fsr --mangoapp -- %command%
            # capSysNice = true;
          };
        */
      };
    })
  ];
}
