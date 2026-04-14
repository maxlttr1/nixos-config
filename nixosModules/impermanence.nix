{ lib, config, settings, ... }:

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
    /*boot.initrd.postResumeCommands = lib.mkAfter ''
      mkdir /btrfs_tmp
      mount ${config.custom.impermanence.diskDevice} /btrfs_tmp
      if [[ -e /btrfs_tmp/root ]]; then
                                                    mkdir -p /btrfs_tmp/old_roots
                                                    timestamp=$(date --date="@$(stat -c %Y /btrfs_tmp/root)" "+%Y-%m-%-d_%H:%M:%S")
                                                    mv /btrfs_tmp/root "/btrfs_tmp/old_roots/$timestamp"
      fi

      delete_subvolume_recursively() {
                                                    IFS=$'\n'
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
    '';*/

    /*boot.initrd.postDeviceCommands = lib.mkAfter ''
      LOGFILE=/mnt/rollback.log #  # Available during the boot process for debugging if the rollback fails, but won’t persist.
      echo "[$(date -Is)] Rollback running" > $LOGFILE
      mkdir -p /mnt
      mount -t btrfs -o subvolid=5 /dev/mapper/crypted /mnt

      if [ -d /mnt/root ] && [ -d /mnt/root-blank ]; then
        # Recursively delete all nested subvolumes inside /mnt/root
        btrfs subvolume list -o /mnt/root | cut -f9 -d' ' | while read subvolume; do
          echo "[$(date -Is)] Deleting /$subvolume subvolume..." >> $LOGFILE
          if btrfs subvolume delete "/mnt/$subvolume" >> $LOGFILE 2>&1; then
            echo "[$(date -Is)] Deleted /$subvolume successfully." >> $LOGFILE
          else
            echo "[$(date -Is)] Failed to delete /$subvolume!" >> $LOGFILE
          fi
        done

        echo "[$(date -Is)] Deleting /root subvolume..." >> $LOGFILE
        if btrfs subvolume delete /mnt/root >> $LOGFILE 2>&1; then
          echo "[$(date -Is)] Deleted /root successfully." >> $LOGFILE
        else
          echo "[$(date -Is)] Failed to delete /root!" >> $LOGFILE
        fi

        echo "[$(date -Is)] Restoring blank /root subvolume..." >> $LOGFILE
        if btrfs subvolume snapshot /mnt/root-blank /mnt/root >> $LOGFILE 2>&1; then
          echo "[$(date -Is)] Restored blank /root successfully." >> $LOGFILE
        else
          echo "[$(date -Is)] Failed to restore blank /root!" >> $LOGFILE
        fi
      fi

      umount /mnt
    '';*/

    fileSystems."/persist".neededForBoot = true;
    environment.persistence."/persist" = {
      hideMounts = true;
      directories = [
        "/var/log" # System logs
        "/var/lib/bluetooth" # Bluetooth pairings
        "/var/lib/nixos" # Nixos state
        "/var/lib/NetworkManager" # Network device state - remembers connection
        "/var/lib/systemd/coredump" # Crash dumps
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
