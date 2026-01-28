{ lib, config, ... }:

{
  options = {
    hostname = lib.mkOption {
      description = "Choose hostname configuration";
      default = "default-${config.users.mainUsername}";
      type = lib.types.str;
    };
  };

  config = {
    networking.hostName = config.hostname;
  };
}
