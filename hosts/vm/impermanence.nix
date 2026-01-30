{ settings, ... }:

{
  # Automatically remove roots that are older than 30 days
  boot.initrd.postResumeCommands = lib.mkAfter ''
    mkdir /btrfs_tmp
    mount /dev/disk/by-partlabel/disk-main-root /btrfs_tmp # CONFIRM THIS IS CORRECT FROM findmnt
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

    for i in $(find /btrfs_tmp/old_roots/ -maxdepth 1 -mtime +30); do
        delete_subvolume_recursively "$i"
    done

    btrfs subvolume create /btrfs_tmp/root
    umount /btrfs_tmp
  '';

  fileSystems."/persist".neededForBoot = true;
  environment.persistence."/persist" = {
    # hideMounts = true;
    hideMounts = false;
    directories = [
      "/var/log" # System logs
      /var/lib/bluetooth/ # Bluetooth pairings
      "/var/lib/nixos" # Nixos state
      "/var/lib/NetworkManager" # Network device state - remembers connection
      "/var/lib/systemd/coredump" # Crash dumps
      "/etc/NetworkManager/system-connections"  # WiFi/network profiles - remember networks
    ];
    files = [
      "/etc/machine-id"
    ];
    users."${settings.username}" = {
      directories = [
        "Downloads"
        "Pictures"
        "Documents"
        "Videos"
        { directory = ".ssh" }
        { directory = ".var/app/" } # Flatpak app data
        ".local/share/direnv" # Direnv states
      ];
      files = [
        ".config/sops/age/keys.txt"
      ];
    };
  };
}