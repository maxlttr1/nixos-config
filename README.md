# My NixOS Config

This repo powers all my machines with a single, declarative, reproducible configuration.

---

## Features

- **Nix Flakes**: Fully flake-based configuration.
- **Disko**: Declarative disk partitioning and formatting.
- **nixos-anywhere**: Easy Remote deployment.
- **Plasma Manager**: Declarative KDE Plasma setup via plasma-manager
- **Docker**: Containers declared and managed through Nix.
- **Dev Environment**: Languages, tools, and editor setup.
- **Syncthing**: Seamless file sync between machines.
- **SOPS**: Secrets management.
- **Tailscale**: Zero-config VPN and remote access.
- **Gaming Support**: Steam, Proton, and Samba for file sharing.
- **System Auto-Upgrade**: Keeps systems up-to-date.
- **GitHub Actions**: CI updates flake inputs automatically and makes a PR (to test the changes before merging).

---

## Remote deployment

### 1. On Nixos remote
```bash
passwd # Change the default passwd for the ssh connection
``` 

### 2. Copy Age key for decryption
```bash
cd /tmp
root=$(mktemp -d)
sudo cp --verbose --archive --parents /etc/sops/age/keys.txt ${root}
```

### 3. Generate Hardware Config and deploy
```bash
sudo nix run github:nix-community/nixos-anywhere -- \
  --generate-hardware-config nixos-generate-config ./hosts/terra-terra/hardware-configuration.nix \
  # --disk-encryption-keys /tmp/disk-encryption.key <(pass DISK-ENCRYPTION-PASSWD) \
  --extra-files $root \
  --flake github:maxlttr1/nixos-config#terra-terra \
  --target-host nixos@192.168.1.22
```

## Local deployment

### 1. Partition & Mount Disks (⚠️ Destroys data)
```bash
echo "DISK-ENCRYPTION-PASSWD" > /tmp/disk-encryption.key
curl -O https://raw.githubusercontent.com/maxlttr1/nixos-config/refs/heads/master/hosts/terra-terra/disko.nix
sudo nix --experimental-features "nix-command flakes" run github:nix-community/disko/latest -- \
  --mode destroy,format,mount \
  ./disko.nix
```
### 2. Import your ssh keys in `/mnt/etc/sops/age/keys.txt` in order for nix-sops to work

### 3. Install Nixos (ensure having the correct hardware-configuration)
```bash
sudo nixos-install --flake github:maxlttr1/nixos-config#terra-terra
```

### 4. Encrypted impermanence setups only: Create a Blank Snapshot of /root
```bash
sudo cryptsetup open /dev/disk/by-partlabel/luks crypted
sudo mount -o subvolid=5 /dev/mapper/crypted /mnt
```

List the contents:
```bash
ls /mnt
# you should see something like
root   home  nix  persist  log  lib  ...
```
Now we can take a snapshot of the root subvolume:
```bash
sudo btrfs subvolume snapshot -r /mnt/root /mnt/root-blank
```
Verify Your Blank Snapshot:
```bash
sudo btrfs subvolume list /mnt
```
You should see output containing both root and root-blank subvolumes:
```bash
ID 256 gen ... path root
ID 257 gen ... path root-blank
```
Check that the snapshot is read only, this ensures that our snapshot will remain the same as the day we took it. It was set ro in disko but lets check anyways:
```bash
sudo btrfs property get -ts /mnt/root-blank
# output should be
ro=true
```
Make sure to unmount and check that everything is fine:
```bash
sudo umount /mnt
sudo btrfs subvolume list /
```
