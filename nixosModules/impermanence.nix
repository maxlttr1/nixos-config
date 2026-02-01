{ lib, config, settings, ... }:

{
  options = {
    impermanence.enable = lib.mkEnableOption "Enable impermanence features";
    impermanence.retentionDays = lib.mkOption {
      type = lib.types.str;
      default = "30";
      description = "Number of days to retain old roots.";
    };
    impermanence.diskDevice = lib.mkOption {
      type = lib.types.str;
      description = "The disk device where the Btrfs subvolumes are located. Confirm this is correct from 'findmnt'.";
      example = "/dev/sda2";
    };
  };

  config = lib.mkIf config.impermanence.enable {
    # Automatically remove roots that are older than 30 days
    boot.initrd.postResumeCommands = lib.mkAfter ''
			mkdir /btrfs_tmp
			mount ${config.impermanence.diskDevice} /btrfs_tmp
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

			for i in $(find /btrfs_tmp/old_roots/ -maxdepth 1 -mtime +${config.impermanence.retentionDays}); do
					delete_subvolume_recursively "$i"
			done

			btrfs subvolume create /btrfs_tmp/root
			umount /btrfs_tmp
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
        "/etc/NetworkManager/system-connections" # WiFi/network profiles - remember networks
        # "/var/lib/flatpak/" # Flatpak system-wide runtimes data (runtimes, applications and configuration)
      ];
      files = [
        "/etc/machine-id"
        "/var/lib/swapfile"
      ];
      users."${settings.username}" = lib.mkIf config.users.enable {
        directories = [
          "Downloads"
          "Pictures"
          "Documents"
          "Videos"
          ".ssh"
          ".local/share/direnv" # Direnv states
          ".local/share/fish" # fish shell data
          ".config/fish" # fish shell config
          ".config/Code" # VSCode
          ".vscode" # VSCode
        ]
        ++ lib.optionals config.kdePlasma.enable [
          ".local/share/kwalletd" # KWallet data
        ]
        ++ lib.optionals config.flatpak.enable [
          ".var/app/" # Flatpak per-user, app-specific config, caches, and data
          ".local/share/flatpak" # Flatpak per-user data (runtimes, applications and configuration)
        ]
        ++ lib.optionals config.syncthing.enable [
          ".config/syncthing" # Syncthing config (settings, keys)
        ];
        files = [
          ".config/sops/age/keys.txt"
          ".local/share/z/data" # zoxide data file
        ];
      };
    };
  };
}
