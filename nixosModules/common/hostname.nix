{ lib, config, settings, ... }:

{
  options = {
    hostname = lib.mkOption {
      description = "Choose hostname configuration";
      default = "default-${settings.username}";
      type = lib.types.str;
    };
  };

  config = {
    networking.hostName = config.hostname;
  };
}
