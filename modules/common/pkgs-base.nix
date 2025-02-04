{ pkgs, ... }:

{
  environment.systemPackages = 
    (with pkgs; [
        git
    ])
    ++
    (with pkgs.unstable; [
    ]);
}