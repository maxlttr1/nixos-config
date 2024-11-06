{ pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    curl
    fastfetch
    git
    jdk #Java LTS
    #linux-firmware
    python312
    python312Packages.matplotlib
    python312Packages.pip
    python312Packages.pytest
    tree
    unzip
    wget
  ];
}