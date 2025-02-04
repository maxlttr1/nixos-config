# shell.nix
{ pkgs ? import <nixpkgs> {} }:

pkgs.mkShell {
  buildInputs = with pkgs; [
    libgcc
    python314Full
    python312Packages.numpy
    python312Packages.matplotlib
    python312Packages.i3ipc
    python312Packages.pip
    python312Packages.virtualenv
    nodejs
    yarn
  ];
}