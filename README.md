# Deployment

- **nixos-anywhere:**
```bash
nix run github:nix-community/nixos-anywhere -- --flake github:maxlttr1/nixos-config#desktop-maxlttr --target-host nixos@192.168.1.11
```

- **disko:**
```bash
sudo nix --experimental-features "nix-command flakes" run github:nix-community/disko/latest -- --mode destroy,format,mount --flake github:maxlttr1/nixos-config/hosts/desktop/disko.nix
```
```bash
nixos-install --flake github:maxlttr1/nixos-config#desktop-maxlttr
```