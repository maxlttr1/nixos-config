{
  config,
  lib,
  pkgs,
  ...
}:

{
  options.custom.gaming.enable = lib.mkEnableOption "Enables gaming packages";

  config = lib.mkIf config.custom.gaming.enable {
    environment.systemPackages = with pkgs; [
      gamemode # MANGOHUD_CONFIG=fps_limit=60 mangohud gamemoderun %command%
      mangohud # Shift_R+F12 : Toggle Hud / mangohud %command%
    ];

    hardware.xone.enable = true; # Xbox One controller support

    programs = {
      steam = {
        enable = true;
        remotePlay.openFirewall = true;
        # gamescopeSession.enable = true; # Run a GameScope driven Steam session from your display-manager
      };
      /*gamescope = {
        enable = true; # gamescope -w 1280 -h 720 -W 1920 -H 1080 -r 70 -f -F fsr --mangoapp -- %command%
        # capSysNice = true;
      };*/
    };
  };
}