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
        BlockAboutAddons = false;
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
            "sponsorBlocker@ajay.app" = {
              install_url = moz "sponsorblock";
              installation_mode = "force_installed";
            };
            "enhancerforyoutube@maximerf.addons.mozilla.org" = {
              install_url = moz "enhancer-for-youtube";
              installation_mode = "force_installed";
            };
            "{446900e4-71c2-419f-a6a7-df9c091e268b}" = {
              install_url = moz "bitwarden_password_manager";
              installation_mode = "force_installed";
            };
          };
        Homepage = {
          URL = "https://nextcloud.maxlttr.fr/apps/dashboard/";
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
          Default = "DuckDuckGo";
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
