{ pkgs, settings, ... }:

{ boot.kernelPackages = pkgs."${settings.kernel}"; }
