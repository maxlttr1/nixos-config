{ lib, config, ... }:
{
  options.custom.firefox.enable = lib.mkEnableOption "Enable Firefox browser";

  config = lib.mkIf config.custom.firefox.enable {
    programs.firefox = {
      enable = true;
      languagePacks = [
        "en-US"
        "fr"
      ];
      configPath = "${config.xdg.configHome}/mozilla/firefox";
      policies = {
        AutofillAddressEnabled = false;
        AutofillCreditCardEnabled = false;
        BlockAboutAddons = true;
        DisableAppUpdate = true;
        DisableFirefoxStudies = true;
        DisableFirefoxAccounts = true;
        DisableFormHistory = true;
        DisableTelemetry = true;
        DisplayBookmarksToolbar = "always";
        DNSOverHTTPS = {
          Enabled = true;
          ProviderURL = "https://family.dns.mullvad.net/dns-query";
          Locked = true;
        };
        EnableTrackingProtection = {
          Category = "strict";
        };
        ExtensionSettings =
          let
            moz = short: "https://addons.mozilla.org/firefox/downloads/latest/${short}/latest.xpi";
          in
          {
            "*".installation_mode = "blocked";
            "uBlock0@raymondhill.net" = {
              install_url = moz "ublock-origin";
              installation_mode = "force_installed";
            };
            "78272b6fa58f4a1abaac99321d503a20@proton.me" = {
              install_url = moz "proton-pass";
              installation_mode = "force_installed";
            };
            "sponsorBlocker@ajay.app" = {
              install_url = moz "sponsorblock";
              installation_mode = "force_installed";
            };
            "myallychou@gmail.com" = {
              install_url = moz "youtube-recommended-videos"; # Unhook
              installation_mode = "force_installed";
            };
            "{a8cf72f7-09b7-4cd4-9aaa-7a023bf09916}" = {
              install_url = moz "besttimetracker";
              installation_mode = "force_installed";
            };
          };
        Homepage = {
          URL = "about:blank";
          StartPage = "previous-session";
        };
        HttpsOnlyMode = "force_enabled";
        NewTabPage = false;
        NoDefaultBookmarks = true;
        OfferToSaveLogins = false;
        PasswordManagerEnabled = false;
        PromptForDownloadLocation = true;
        SanitizeOnShutdown = true;
        SearchEngines = {
          Default = "Ecosia";
          Remove = [
            "Google"
            "Bing"
            "Amazon.com"
            "eBay"
            "Twitter"
            "Perplexity"
            "Wikipedia (en)"
          ];
          PreventInstalls = false;
        };
        SkipTermsOfUse = true;
        UserMessaging = {
          MoreFromMozilla = false;
          FirefoxLabs = false;
          Locked = true;
        };
      };
    };
  };
}
