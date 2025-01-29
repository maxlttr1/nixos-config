{ pkgs, ... }:

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
  # Flatpaks
  services.flatpak.packages = [
    #"co.logonoff.awakeonlan"
  ];

  environment.systemPackages = 
    (with pkgs; [
      kdePackages.bluedevil #Bluetooth for kde
      bibata-cursors
      curl
      discord
      fastfetch
      ffmpeg
      git
      jdk #Java LTS
      jetbrains-mono
      papirus-icon-theme
      protonvpn-gui
      tree
      unzip
      vscode
      wget
      kdePackages.yakuake
    ])
    ++
    (with pkgs.unstable; [
    ]);
 
  services.flatpak = {
    enable = true;
    update = {
      auto = {
        enable = true;
        onCalendar = "daily";
      };
    };
  };

  programs.firefox = {
    enable = true;
    preferences = {
      "widget.use-xdg-desktop-portal.file-picker" = 1; # Use the file picker offered by the XDG Desktop Portal framework
    };
    languagePacks = [ "en-US" ];
    
    /* ---- POLICIES ---- */
    # Check about:policies#documentation for options.
    policies = {
      /* ---- EXTENSIONS ---- */
      # Check about:support for extension/add-on ID strings.
      # Valid strings for installation_mode are "allowed", "blocked",
      # "force_installed" and "normal_installed".
      ExtensionSettings = {
        "*".installation_mode = "blocked"; # blocks all addons except the ones specified below
        
        # uBlock Origin:
        "uBlock0@raymondhill.net" = {
          install_url = "https://addons.mozilla.org/firefox/downloads/latest/ublock-origin/latest.xpi";
          installation_mode = "normal_installed";
        };
        
        # Unhook (YouTube Disabler):
        "unhook@raymondhill.net" = {
          install_url = "https://addons.mozilla.org/firefox/downloads/latest/unhook/latest.xpi";
          installation_mode = "force_installed";
        };

        # Proton Pass (Password Manager):
        "protonpass@protonmail.com" = {
          install_url = "https://addons.mozilla.org/firefox/downloads/latest/proton-pass/latest.xpi";
          installation_mode = "normal_installed";
        };

        # SponsorBlock (Skip YouTube sponsor segments):
        "sponsorblock@sponsor.rix0r" = {
          install_url = "https://addons.mozilla.org/firefox/downloads/latest/sponsorblock/latest.xpi";
          installation_mode = "normal_installed";
        };
      };

      /* ---- PREFERENCES ---- */
      # Check about:config for options.
      Preferences = { 
        "browser.contentblocking.category" = { Value = "strict"; Status = "locked"; };
        "browser.contentblocking.fingerprinting.preferences.ui.enabled" = lock-true;
        "browser.contentblocking.reject-and-isolate-cookies.preferences.ui.enabled" = lock-true;
        "browser.formfill.enable" = lock-false;
        "browser.newtabpage.activity-stream.feeds.section.topstories" = lock-false;
        "browser.newtabpage.activity-stream.feeds.snippets" = lock-false;
        "browser.newtabpage.activity-stream.section.highlights.includePocket" = lock-false;
        "browser.newtabpage.activity-stream.section.highlights.includeBookmarks" = lock-false;
        "browser.newtabpage.activity-stream.section.highlights.includeDownloads" = lock-false;
        "browser.newtabpage.activity-stream.section.highlights.includeVisited" = lock-false;
        "browser.newtabpage.activity-stream.showSponsored" = lock-false;
        "browser.newtabpage.activity-stream.system.showSponsored" = lock-false;
        "browser.newtabpage.activity-stream.showSponsoredTopSites" = lock-false;
        "browser.search.suggest.enabled" = lock-false;
        "browser.search.suggest.enabled.private" = lock-false;
        "browser.topsites.contile.enabled" = lock-false; # Disables the Top Sites feature, meaning users won’t see suggested sites based on their browsing habits on the New Tab Page
        "browser.translations.neverTranslateLanguages" = [ "en" "fr" ];
        "datareporting.healthreport.uploadEnabled" = lock-false; # Disables data collection
        "extensions.formautofill.addresses.enabled" = lock-false;
        "extensions.formautofill.creditCards.enabled" = lock-false;
        "extensions.pocket.enabled" = lock-false; # Disables Pocket integration in Firefox
        "identity.fxaccounts.enabled" = lock-false; # Disable Firefox accounts
        "identity.fxaccounts.oauth.enabled" = lock-false;
        "identity.fxaccounts.pairing.enable" = lock-false;
        "media.hardware-video-decoding.enabled" = lock-true;
        "network.cookie.cookieBehavior" = 1; # Block third-party cookies (default)
        "network.trr.disable-ECS" = lock-true;
        "network.trr.uri" = "https://mozilla.cloudflare-dns.com/dns-query";
        "network.trr.mode" = 2; # Enable DNS over HTTPS (DoH) for all queries
        "privacy.firstparty.isolate" = lock-true; # Isolates cookies and storage for each site, improving privacy by preventing cross-site tracking
        "privacy.donottrackheader.enabled" = lock-true; # Sends a Do Not Track request in the HTTP header
        "privacy.resistFingerprinting" = lock-true; # Reduces your device's unique signature (blocks certain data like screen resolution, time zone, etc.)
        "privacy.trackingprotection.enabled"= lock-true;
        "privacy.trackingprotection.cryptomining.enabled" = lock-true; # Blocks cryptomining scripts 
        "privacy.trackingprotection.pbmode.enabled" = lock-true; # Enables tracking protection in Private Browsing mode
        "privacy.trackingprotection.socialtracking.enabled" = lock-true; # locks social media tracking, including cookies and scripts used by social media platforms to track users across different websites
        "signon.rememberSignons" = lock-false; 
        "toolkit.telemetry.enabled" = lock-false; # Do not send telemetry data to Mozilla
      };
    };
  };
}
