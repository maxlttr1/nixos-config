{ lib, config, ... }:

{
  options = {
    custom.atd.enable = lib.mkEnableOption "Enable atd job scheduler daemon";
  };

  config = lib.mkIf config.custom.atd.enable {
    services.atd.enable = true; # Daemon that runs jobs scheduled using the at or batch commands.
    # services.atd.allowEveryone = true;
  };
}
