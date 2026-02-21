{ lib, config, settings, ... }:

{
  options = {
    custom.hostname = lib.mkOption {
      description = "Choose hostname configuration";
      default = "default-${settings.username}";
      type = lib.types.str;
    };
  };

  config = {
    networking.hostName = config.custom.hostname;
  };
}
