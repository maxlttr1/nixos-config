{
  lib,
  config,
  settings,
  ...
}:

{
  options = {
    custom.impermanence.enable = lib.mkEnableOption "Enable impermanence features";
    custom.impermanence.retentionDays = lib.mkOption {
      type = lib.types.str;
      default = "30";
      description = "Number of days to retain old roots.";
    };
    custom.impermanence.diskDevice = lib.mkOption {
      type = lib.types.str;
      description = "The disk device where the Btrfs subvolumes are located. Confirm this is correct from 'findmnt'.";
      example = "/dev/sda2";
    };
  };

  config = lib.mkIf config.custom.impermanence.enable {
    /*
      boot.initrd.postResumeCommands = lib.mkAfter ''
        mkdir /btrfs_tmp
        mount ${config.custom.impermanence.diskDevice} /btrfs_tmp
        if [[ -e /btrfs_tmp/root ]]; then
          mkdir -p /btrfs_tmp/old_roots
          timestamp=$(date --date="@$(stat -c %Y /btrfs_tmp/root)" "+%Y-%m-%-d_%H:%M:%S")
          mv /btrfs_tmp/root "/btrfs_tmp/old_roots/$timestamp"
        fi

        delete_subvolume_recursively() {
          for i in $(btrfs subvolume list -o "$1" | cut -f 9- -d ' '); do
            delete_subvolume_recursively "/btrfs_tmp/$i"
          done
          btrfs subvolume delete "$1"
        }

        for i in $(find /btrfs_tmp/old_roots/ -maxdepth 1 -mtime +${config.custom.impermanence.retentionDays}); do
          delete_subvolume_recursively "$i"
        done

        btrfs subvolume create /btrfs_tmp/root
        umount /btrfs_tmp
      '';
    */

    boot.initrd.postDeviceCommands = lib.mkAfter ''
      set -euo pipefail
      echo "Starting impermanence rollback (safe mode)..."

      LUKS_DEVICE="/dev/mapper/crypted"
      if [[ ! -b "$LUKS_DEVICE" ]]; then
        echo "LUKS device $LUKS_DEVICE not found! Aborting impermanence rollback."
        exit 1
      fi

      mkdir -p /mnt
      if ! mount -o subvol=/ "$LUKS_DEVICE" /mnt; then
        echo "Error: Failed to mount root filesystem"
        exit 1
      fi

      if [[ ! -d "/mnt/root-blank" ]]; then
        echo "Error: /mnt/root-blank snapshot not found, skipping rollback"
        umount /mnt || true
        exit 1
      fi

      echo "Found root-blank snapshot, proceeding with safe rollback"

      # Move current root aside instead of deleting it (avoid kernel panic)
      if [[ -d "/mnt/root" ]]; then
        mv /mnt/root "/mnt/root-old-$(date +%s)"
      fi

      # Restore root-blank snapshot as new root
      btrfs subvolume snapshot /mnt/root-blank /mnt/root

      umount /mnt
    '';

    fileSystems."/persist".neededForBoot = true;
    environment.persistence."/persist" = {
      hideMounts = true;
      directories = [
        "/var/log" # System logs
        "/var/lib/bluetooth" # Bluetooth pairings
        "/var/lib/nixos" # Nixos state
        "/var/lib/NetworkManager" # Network device state - remembers connection
        "/var/lib/systemd/coredump" # Crash dumps
        "/var/lib/sbctl" # sbctl keys and data (lanzaboote)
        "/etc/NetworkManager/system-connections" # WiFi/network profiles - remember networks
        # "/var/lib/flatpak/" # Flatpak system-wide runtimes data (runtimes, applications and configuration)
      ];
      files = [
        "/etc/machine-id"
        "/etc/sops/age/keys.txt"
        "/var/lib/swapfile"
      ];
      users."${settings.username}" = lib.mkIf config.custom.users.enable {
        directories = [
          "Desktop"
          "Downloads"
          "Pictures"
          "Documents"
          "Videos"
          ".ssh"
          ".local/share/direnv" # Direnv states
          ".local/share/fish" # fish shell data
          ".config/fish" # fish shell config
          ".local/share/z" # zoxide
          ".config/Code" # VSCode
          ".vscode" # VSCode
        ]
        ++ lib.optionals config.custom.kdePlasma.enable [
          ".local/share/kwalletd" # KWallet data
        ]
        ++ lib.optionals config.custom.flatpak.enable [
          ".var/app/" # Flatpak per-user, app-specific config, caches, and data
          ".local/share/flatpak" # Flatpak per-user data (runtimes, applications and configuration)
        ]
        ++ lib.optionals config.custom.syncthing.enable [
          ".config/syncthing" # Syncthing config (settings, keys)
        ];
      };
    };
  };
}
