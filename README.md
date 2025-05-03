# 🐧 My NixOS Config

This repo powers all my machines with a single, declarative, reproducible configuration.

---

## 🚀 Features

- ⚙️ **Nix Flakes**: Fully flake-based configuration.
- 💾 **Disko**: Declarative disk partitioning and formatting.
- 🌐 **nixos-anywhere**: Easy Remote deployment.
- 🧠 **Plasma Manager**: Declarative KDE Plasma setup via plasma-manager
- 🐳 **Docker**: Containers declared and managed through Nix.
- 💻 **Dev Environment**: Languages, tools, and editor setup.
- 🔁 **Syncthing**: Seamless file sync between machines.
- 🔐 **SOPS**: Secrets management.
- 🕸️ **Tailscale**: Zero-config VPN and remote access.
- 🎮 **Gaming Support**: Steam, Proton, and Samba for file sharing.
- 🔄 **System Auto-Upgrade**: Keeps systems up-to-date.
- 🤖 **GitHub Actions**: CI updates flake inputs automatically and makes a PR (to test the changes before merging).

---

## 🛠️ Deployment from host

### 1. Copy Age key for decryption
```bash
cd /tmp
root=$(mktemp -d)
sudo cp --verbose --archive --parents /etc/sops/age/keys.txt ${root}
```

### 2. Generate Hardware Config and deploy
```bash
sudo nix run github:nix-community/nixos-anywhere -- \
  --generate-hardware-config nixos-generate-config ./hosts/desktop/hardware-configuration.nix \
  --extra-files $root \
  --flake github:maxlttr1/nixos-config#desktop-maxlttr \
  --target-host nixos@192.168.1.11
```

## 🛠️ Deployment on host

### 1. Partition & Mount Disks (⚠️ Destroys data)
```bash
sudo nix --experimental-features "nix-command flakes" run github:nix-community/disko/latest -- \
  --mode destroy,format,mount \
  --flake github:maxlttr1/nixos-config/hosts/desktop/disko.nix
```

### 2. Install Nixos
```bash
nixos-install --flake github:maxlttr1/nixos-config#desktop-maxlttr
```

## 🔧 Maintaining

### Remote Rebuild via SSH

```bash
sudo nixos-rebuild switch \
  --flake github:maxlttr1/nixos-config \
  --build-host localhost \
  --target-host root@192.168.1.75 \
  --verbose
```

## 🤝 Contributing

Contributions are very welcome! If you spot a bug, have an idea, or want to improve something !
