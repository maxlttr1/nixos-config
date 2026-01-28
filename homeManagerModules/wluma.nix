{ config, lib, ... }:

{
  options.wluma.enable = lib.mkEnableOption "wluma brightness manager";

  config = lib.mkIf config.wluma.enable {
    services.wluma = {
      enable = true;
      settings = {
        als = {
          webcam = {
            video = 0;
            # Run RUST_LOG=trace wluma / RUST_LOG=debug wluma
            thresholds = {
              "0" = "night";
              "20" = "dim";
              "50" = "normal";
              "80" = "bright";
              "100" = "outdoors";
            };
          };
        };
        output = {
          backlight = [
            {
              name = "eDP-1";
              path = "/sys/class/backlight/intel_backlight/";
              capturer = "none";
            }
          ];
        };
      };
    };
  };
}
