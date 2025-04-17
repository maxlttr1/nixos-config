# Deployment

## Nixos-anywhere
- Copy `keys.txt`
```bash
cd /tmp
root=$(mktemp -d)
sudo cp --verbose --archive --parents /etc/sops/age/keys.txt ${root}
```
- To generate `hardware-configuration.nix`
```bash
sudo nix run github:nix-community/nixos-anywhere -- --generate-hardware-config nixos-generate-config ./hosts/desktop/hardware-configuration.nix --extra-files $root --flake github:maxlttr1/nixos-config#desktop-maxlttr --target-host nixos@192.168.1.11
```

## Disko:
```bash
sudo nix --experimental-features "nix-command flakes" run github:nix-community/disko/latest -- --mode destroy,format,mount --flake github:maxlttr1/nixos-config/hosts/desktop/disko.nix
```
```bash
nixos-install --flake github:maxlttr1/nixos-config#desktop-maxlttr
```

# Maintaining

```bash
nixos-rebuild switch --flake github:maxlttr1/nixos-config --build-host localhost --target-host root@192.168.1.75 --verbose
```