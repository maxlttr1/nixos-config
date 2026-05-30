{
  lib,
  config,
  settings,
  ...
}:

{
  options = {
    custom.fsOptimizations.enable = lib.mkEnableOption "Filesystem mount options for performance and security";
  };

  config = lib.mkIf config.custom.fsOptimizations.enable {
    fileSystems = {
      "/".options = lib.mkAfter [
        "noatime"
        "nosuid"
        "nodev"
      ];
      "/run/media" = {
        device = "/run/media";
        fsType = "ext4";
        options = lib.mkAfter [
          "bind"
          "noexec"
        ];
      };
      "/home/${settings.username}/Public" = lib.mkIf config.custom.users.enable {
        device = "/home/${settings.username}/Public";
        fsType = "ext4";
        options = lib.mkAfter [
          "bind"
          "noexec"
        ];
      };
      "/home/${settings.username}/Downloads" = lib.mkIf config.custom.users.enable {
        device = "/home/${settings.username}/Downloads";
        fsType = "ext4";
        options = lib.mkAfter [
          "bind"
          "noexec"
        ];
      };
    };

    boot.tmp = {
      cleanOnBoot = true;
      useTmpfs = true;
    };

    services.fstrim = {
      enable = true;
      interval = "weekly";
    };
  };
}
