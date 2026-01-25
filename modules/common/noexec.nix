{
  # Mark all partitions except /nix/store as noexec
  # Only /nix/store (and its symlinks) are allowed to execute binaries
  # Since we only have / and /boot, just mark those as noexec

  fileSystems."/" = {
    options = [ "nosuid" "nodev" ];
  };
}
