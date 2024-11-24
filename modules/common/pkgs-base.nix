{ pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    curl
    fastfetch
    git
    tree
    unzip
    wget
  ];
}