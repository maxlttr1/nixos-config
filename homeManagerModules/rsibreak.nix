{ lib, config, ... }:

{
  options.custom.rsibreak.enable = lib.mkEnableOption "Enable RSI Break";

  config = lib.mkIf config.custom.rsibreak.enable {
    services.rsibreak.enable = true;
  };
}
