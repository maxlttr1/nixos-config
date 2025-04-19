{ pkgs, lib, ... }:

let
    lock-false = {
      Value = false;
      Status = "locked";
    };
    lock-true = {
      Value = true;
      Status = "locked";
    };
in

{
  programs.firefox = {
    enable = true;
    package = pkgs.librewolf;
    preferences = {
      "browser.translations.automaticallyPopup" = false; # Always offer to translate
      "privacy.clearOnShutdown.history" = false;
    };
    policies = {
      "AutofillAddressEnabled" =  false;
      "AutofillCreditCardEnabled" = false;
      "DNSOverHTTPS" = {
        "Enabled" =  true;
        "ProviderURL" = "https://dns.quad9.net/dns-query";
        "Locked" = false;
        "Fallback" = true;
      };
      # Check about:support for extension/add-on ID strings.
      ExtensionSettings = {
        #"*".installation_mode = "blocked"; # blocks all addons except the ones specified below        
        "uBlock0@raymondhill.net" = {
          install_url = "https://addons.mozilla.org/firefox/downloads/latest/ublock-origin/latest.xpi";
          installation_mode = "force_installed";
        };
        "myallychou@gmail.com" = {
          install_url = "https://addons.mozilla.org/firefox/downloads/file/4263531/youtube_recommended_videos-1.6.7.xpi";
          installation_mode = "force_installed";
        };
        "78272b6fa58f4a1abaac99321d503a20@proton.me" = {
          install_url = "https://addons.mozilla.org/firefox/downloads/file/4423344/proton_pass-1.28.0.xpi";
          installation_mode = "force_installed";
        };
        "sponsorBlocker@ajay.app" = {
          install_url = "https://addons.mozilla.org/firefox/downloads/file/4422523/sponsorblock-5.11.2.xpi";
          installation_mode = "force_installed";
        };
      };
      "Homepage"= {
        "Locked" = false;
        "StartPage" = "previous-session";
      };
      "HttpsOnlyMode" = "enabled";
      /*"ManagedBookmarks" = [
        {
          "name" = "Social";
          "children" = [
            {
              "url" = "youtube.com";
              "name" = "Youtube";
            }
          ];
        }
      ];*/
      "OfferToSaveLoginsDefault" = false;
      "SearchEngines" = {
        "Default" = "DuckDuckGo";
        "Remove" = [
          "Google"
          "Bing"
          "Wikipedia"
        ];
      };
    };
  };
}