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
      "Cookies" = {
        "Allow" = [
          "http://github.com"
          "https://github.com"
          
          "http://youtube.com"
          "http://youtube.com"

          "http://google.com"
          "https://google.com"

          "http://proton.me"
          "https://proton.me"

          "http://univ-nantes.fr"
          "https://univ-nantes.fr"
        ];
      };
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
        "addon@darkreader.org" = {
          install_url = "https://addons.mozilla.org/firefox/downloads/file/4439735/darkreader-4.9.103.xpi";
          installation_mode = "force_installed";
        };
        # Gestures
        "{506e023c-7f2b-40a3-8066-bc5deb40aebe}" = {
          install_url = "https://addons.mozilla.org/firefox/downloads/file/4330901/gesturefy-3.2.13.xpi";
          installation_mode = "force_installed";
        };
        "addons-search-detection@mozilla.com" = {
          install_url = "https://addons.mozilla.org/firefox/downloads/file/4432391/save_chatgpt_as_pdf-1.25.xpi";
          installation_mode = "force_installed";
        };
        # Image searcher
        "{2e5ff8c8-32fe-46d0-9fc8-6b8986621f3c}" = {
          install_url = "https://addons.mozilla.org/firefox/downloads/file/4473439/search_by_image-8.2.0.xpi";
          installation_mode = "force_installed";
        };
      };
      "Homepage"= {
        "Locked" = false;
        "StartPage" = "previous-session";
      };
      "HttpsOnlyMode" = "enabled";
      "ManagedBookmarks" = [
        {
          "name" = "Youtube";
          "url" = "youtube.com";
        }
        {
          "name" = "Proton";
          "url" = "account.proton.me/apps";
        }
        {
          "name" = "Madoc";
          "url" = "madoc.univ-nantes.fr";
        }
        {
          "name" = "Gestnote";
          "url" = "scolarite.polytech.univ-nantes.fr";
        }
        {
          "name" = "BourseDirect";
          "url" = "www.boursedirect.fr/fr/login";
        }
      ];
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