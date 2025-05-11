{ pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    fancontrol_gui
  ];
}