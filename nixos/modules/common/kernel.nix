{ pkgs, kernel, ... }:

{boot.kernelPackages = pkgs."${kernel}";}
