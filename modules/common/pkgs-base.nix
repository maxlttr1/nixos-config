{ pkgs, ... }:

{
  environment.systemPackages = 
    (with pkgs; [
    ])
    ++
    (with pkgs.unstable; [
    ]);
}