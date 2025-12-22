{ settings, inputs, ...}:

{
  programs.librewolf = {
    enable = true;
    profiles = {
      ${settings.username} = {
        extensions.packages = with inputs.firefox-addons.packages."x86_64-linux"; [
          proton-pass
          sponsorblock
          ublock-origin
        ];
        settings = {
          "network.trr.uri" = "	https://dns.quad9.net/dns-query";
          "network.trr.mode" = 3;
        };
      };
    };
  };
}