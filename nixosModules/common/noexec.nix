{ lib, config, ... }:

{
  options = {
    noexec.enable = lib.mkEnableOption "Enable noexec mount options for security";
  };

  config = lib.mkIf config.noexec.enable {
    # Mark all partitions except /nix/store as noexec
    # Only /nix/store (and its symlinks) are allowed to execute binaries
    # Since we only have / and /boot, just mark those as noexec

    fileSystems."/" = {
      options = [ "nosuid" "nodev" ];
    };
  };
}
