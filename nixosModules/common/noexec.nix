{ lib, config, settings, ... }:

{
  options = {
    custom.noexec.enable = lib.mkEnableOption "Enable noexec mount options for security";
  };

  config.fileSystems = lib.mkIf config.custom.noexec.enable {
    "/".options = lib.mkIf (!config.custom.impermanence.enable) [
      "nosuid"
      "nodev"
      "noatime"
    ];
    "/tmp" = {
      device = "/tmp";
      options = [
        "bind"
        "noexec"
      ];
    };
    "/run/media" = {
      device = "/run/media";
      options = lib.mkAfter [
        "bind"
        "noexec"
      ];
    };
    "/home/${settings.username}/Public" = lib.mkIf config.custom.users.enable {
      device = "/home/${settings.username}/Public";
      options = lib.mkAfter [
        "bind"
        "noexec"
      ];
    };
    "/home/${settings.username}/Downloads" = lib.mkIf config.custom.users.enable {
      device = "/home/${settings.username}/Downloads";
      options = lib.mkAfter [
        "bind"
        "noexec"
      ];
    };
  };
}
