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
    preferences = {
      "widget.use-xdg-desktop-portal.file-picker" = 1; # Use the file picker offered by the XDG Desktop Portal framework
    };

    languagePacks = [ "en-US" ];

    policies = {
      "AppAutoUpdate" = true;
      "AutofillAddressEnabled" =  false;
      "AutofillCreditCardEnabled" = false;
      "BackgroundAppUpdate" = false;
      "BlockAboutAddons" = false;
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
      "DisableFormHistory" = true; # Turn off saving information on web forms and the search bar
      "DisablePocket" = true;
      "DisablePrivateBrowsing" = true;
      "DisableProfileImport" = true;
      "DisableTelemetry" = true;
      "DNSOverHTTPS" = {
        "Enabled" =  true;
        "ProviderURL" = "https://mozilla.cloudflare-dns.com/dns-query";
        "Locked" = true;
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
          install_url = "https://addons.mozilla.org/firefox/downloads/file/4423344/proton_pass-1.28.0.xpi";
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
        "Locked" = true;
      };
      "FirefoxSuggest" = {
        "WebSuggestions" = false;
        "SponsoredSuggestions" = false;
        "ImproveSuggest" = false;
        "Locked" = true;
      };
      "HardwareAcceleration" = true; # Preferences Affected: layers.acceleration.disabled
      "Homepage"= {
        #"URL"= "http://example.com/";
        "Locked" = true;
        /*"Additional": ["http://example.org/",
                     "http://example.edu/"],*/
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
      "NewTabPage" = false;
      "NoDefaultBookmarks" = true;
      "OfferToSaveLoginsDefault" = false;
      "OverrideFirstRunPage" = ""; # If the value is an empty string (“”), the first run page is not displayed
      "PasswordManagerEnabled" = false;
      "PostQuantumKeyAgreementEnabled" = true;
      "PrivateBrowsingModeAvailability" = 1; # 0 (Private Browsing mode is available), 1 (Private Browsing mode not available), and 2(Private Browsing mode is forced)
      "PromptForDownloadLocation" = true;
      "SanitizeOnShutdown" = true; # All !
      "SearchEngines" = {
        "Default" = "DuckDuckGo";
        "PreventInstalls" = true; 
        "Remove" = [
          "Google"
          "Bing"
          "Wikipedia"
        ];
      };
      "SearchSuggestEnabled" = false;
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
        "browser.contentblocking.category" = { Value = "strict"; Status = "locked"; };
        "browser.contentblocking.fingerprinting.preferences.ui.enabled" = lock-true;
        "browser.contentblocking.reject-and-isolate-cookies.preferences.ui.enabled" = lock-true;
        "browser.topsites.contile.enabled" = lock-false; # Disables the Top Sites feature, meaning users won’t see suggested sites based on their browsing habits on the New Tab Page
        "media.hardware-video-decoding.enabled" = lock-true;
        "network.trr.disable-ECS" = lock-true;
        "privacy.firstparty.isolate" = lock-true; # Isolates cookies and storage for each site, improving privacy by preventing cross-site tracking
        "privacy.donottrackheader.enabled" = lock-true; # Sends a Do Not Track request in the HTTP header
        "privacy.resistFingerprinting" = lock-true; # Reduces your device's unique signature (blocks certain data like screen resolution, time zone, etc.)
        "privacy.trackingprotection.socialtracking.enabled" = lock-true; # locks social media tracking, including cookies and scripts used by social media platforms to track users across different websites
      };
    };
  };
}