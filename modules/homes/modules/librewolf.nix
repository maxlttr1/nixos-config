{ settings, pkgs, ...}:

{
  programs.librewolf = {
    enable = true;
    profiles = {
      ${settings.username} = {
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
          "privacy.clearOnShutdown.cookies" = false;
          "privacy.clearOnShutdown_v2.cookiesAndStorage" = false;
        };
      };
    };
  };
}