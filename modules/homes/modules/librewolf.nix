{ pkgs, ... }:

{
  programs.librewolf = {
    enable = true;
    profiles = {
      "${config.users.mainUsername}" = {
        extensions.packages = with pkgs.firefoxAddons; [
          ublock-origin
          sponsorblock
          proton-pass
          darkreader
        ];
        settings = {
          "network.trr.uri" = "	https://dns.quad9.net/dns-query";
          "network.trr.mode" = 3;
          "browser.startup.page" = 3; # Restore session
        };
      };
    };
  };
}
