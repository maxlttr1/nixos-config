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
  --disk-encryption-keys /tmp/disk-encryption.key <(pass DISK-ENCRYPTION-PASSWD) \
  --extra-files $root \
  --flake github:maxlttr1/nixos-config#terra-terra \
  --target-host nixos@192.168.1.22
```

## Local deployment

### 1. Partition & Mount Disks (⚠️ Destroys data)
```bash
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

