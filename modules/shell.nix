# shell.nix
{ pkgs ? import <nixpkgs> {} }:

pkgs.mkShell {
  buildInputs = with pkgs; [
    jetbrains.clion
    libgcc
    python314Full
    python312Packages.numpy
    python312Packages.matplotlib
    python312Packages.pip
  ];
}