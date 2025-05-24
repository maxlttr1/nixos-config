{ pkgs, lib, ... }:

{
  programs.firefox = {
    enable = true;
    preferences = {
    };
    policies = {
      "AutofillAddressEnabled" =  false;
      "AutofillCreditCardEnabled" = false;
      "BackgroundAppUpdate" = false;
      "BlockAboutProfiles" =  true;
      "Cookies" = {
        #"Allow" = ["http://example.org/"];
        #"AllowSession": ["http://example.edu/"];
        #"Block" = ["http://example.edu/"];
        "Locked" = true;
        "Behavior" = "reject-tracker";
        "BehaviorPrivateBrowsing" = "reject-tracker";
      };
      "DisableAppUpdate" = true;
      "DisableFeedbackCommands" = true;
      "DisableFirefoxAccounts" = true;
      "DisableFirefoxScreenshots" = true;
      "DisableFirefoxStudies" = true;
      "DisablePocket" = true;
      "DisableProfileImport" = true;
      "DisableTelemetry" = true;
      "DNSOverHTTPS" = {
        "Enabled" =  true;
        "ProviderURL" = "https://mozilla.cloudflare-dns.com/dns-query";
        "Locked" = false;
        #"ExcludedDomains" = ["example.com"],
        "Fallback" = true;
      };
      "EnableTrackingProtection" = {
        "Value" = true;
        "Locked" = true;
        "Cryptomining" = true;
        "Fingerprinting" = true;
        "EmailTracking" = true;
        #"Exceptions": ["https://example.com"]
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
          install_url = "https://addons.mozilla.org/firefox/downloads/file/4491195/proton_pass-1.31.2.xpi";
          installation_mode = "force_installed";
        };
        "sponsorBlocker@ajay.app" = {
          install_url = "https://addons.mozilla.org/firefox/downloads/file/4422523/sponsorblock-5.11.2.xpi";
          installation_mode = "force_installed";
        };
      };
      "ExtensionUpdate" = true;
      "FirefoxHome" = {
        "Search" = false;
        "TopSites" = false;
        "SponsoredTopSites" = false;
        "Highlights" = false;
        "Pocket" = false;
        "SponsoredPocket" = false;
        "Snippets" = false;
        "Locked" = false;
      };
      "FirefoxSuggest" = {
        "WebSuggestions" = false;
        "SponsoredSuggestions" = false;
        "ImproveSuggest" = false;
        "Locked" = false;
      };
      "HardwareAcceleration" = true; # Preferences Affected: layers.acceleration.disabled
      "Homepage"= {
        #"URL"= "http://example.com/";
        "Locked" = false;
        /*"Additional": ["http://example.org/",
                     "http://example.edu/"],*/
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
        {
          "name" = "Suaps";
          "url" = "u-sport.univ-nantes.fr/accueil";
        }
      ];
      "NewTabPage" = false;
      "NoDefaultBookmarks" = true;
      "OfferToSaveLoginsDefault" = false;
      "OverrideFirstRunPage" = ""; # If the value is an empty string (“”), the first run page is not displayed
      "PasswordManagerEnabled" = false;
      "PostQuantumKeyAgreementEnabled" = true;
      "PromptForDownloadLocation" = true;
      #"SanitizeOnShutdown" = true; # All !
      "SearchEngines" = {
        "Default" = "DuckDuckGo";
        "PreventInstalls" = false; 
        "Remove" = [
          "Google"
          "Bing"
          "Wikipedia"
        ];
      };
      "SearchSuggestEnabled" = true;
      "TranslateEnabled" = false;
      "UserMessaging" = {
        "ExtensionRecommendations" = false;
        "FeatureRecommendations" = false;
        "UrlbarInterventions" = false;
        "SkipOnboarding" = false;
        "MoreFromMozilla" = false;
        "FirefoxLabs" = false;
        "Locked" = true;
      };
      Preferences = { 
        "browser.contentblocking.fingerprinting.preferences.ui.enabled" = { Value = "true"; Status = "locked"; };
        "browser.contentblocking.reject-and-isolate-cookies.preferences.ui.enabled" = { Value = "true"; Status = "locked"; };
        "network.trr.disable-ECS" = { Value = "true"; Status = "locked"; };
        "privacy.firstparty.isolate" = { Value = "true"; Status = "locked"; }; # Isolates cookies and storage for each site, improving privacy by preventing cross-site tracking
        "privacy.resistFingerprinting" = { Value = "true"; Status = "locked"; }; # Reduces your device's unique signature (blocks certain data like screen resolution, time zone, etc.)
        "privacy.trackingprotection.socialtracking.enabled" = { Value = "true"; Status = "locked"; }; # locks social media tracking, including cookies and scripts used by social media platforms to track users across different websites
      };
    };
  };
}