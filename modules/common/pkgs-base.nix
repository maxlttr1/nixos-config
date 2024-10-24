{ pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    curl
    fastfetch
    git
    jdk #Java LTS
    python312
    python312Packages.pip
    python312Packages.pytest
    tree
    unzip
    wget
  ];
}