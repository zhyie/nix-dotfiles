{ inputs }:
{
  ## General
  DontCheckDefaultBrowser = true;
  OfferToSaveLogins = false;
  GenerativeAI.Enabled = false;
  DisplayBookmarksToolbar = "newtab";
  DisplayMenuBar = "default-off";
  SanitizeOnShutdown = {
    Cache = true;
    FormData = true;
    locked = false;
  };

  ## Firefox
  DisableFirefoxAccounts = true;
  DisableFirefoxStudies = true;
  DisableTelemetry = true;
  FirefoxHome = {
    Search = true;
    TopSites = false;
    SponsoredTopSites = false;
    Highlights = false;
    Pocket = false;
    Stories = false;
    SponsoredPocket = false;
    SponsoredStories = false;
    Snippets = false;
  };
  UserMessaging = {
    ExtensionRecommendations = false;
    FeatureRecommendations = true;
    UrlbarInterventions = false;
    SkipOnboarding = true;
    MoreFromMozilla = false;
    FirefoxLabs = true;
  };

  ## Search
  SearchSuggestEnabled = false;
  SearchEngines = {
    Default = "DuckDuckGo";
    Remove = [
      "Google"
      "Bing"
      "Perplexity"
      "Wikipedia"
    ];
    Add = [
      {
        "Name" = "Startpage";
        "URLTemplate" = "https://www.startpage.com/sp/search?query={searchTerms}";
        "IconURL" = "https://www.startpage.com/favicon.ico";
        "Alias" = "@sp";
      }
    ];
  };

  ## Privacy and Security
  PasswordManagerEnabled = false;
  EnableTrackingProtection = {
    Value = true;
    Locked = true;
    Cryptomining = true;
    Fingerprinting = true;
  };
  HttpsOnlyMode = "force_enabled";
  DNSOverHTTPS = {
    Enabled = true;
    ProviderURL = " https://sky.rethinkdns.com/1:AAoACAgA";
    Fallback = true;
  };
  Cookies = {
    Allow = [
      "https://github.com"
      "https://notion.so"
    ];
    AllowSession = [
      "https://proton.me"
      "https://tuta.com"
    ];
  };

  ## Extensions
  "3rdparty" = {
    Extensions = {
      "uBlock0@raymondhill.net".adminSettings = builtins.readFile (
        inputs.dotfiles + "/firefox/extensions/ublock.txt"
      );
    };
  };
  ExtensionSettings = {
    # ublock origin
    "uBlock0@raymondhill.net" = {
      installation_mode = "force_installed";
      install_url = "https://addons.mozilla.org/firefox/downloads/latest/ublock-origin/latest.xpi";
      private_browsing = true;
    };
    # keepassxc
    "keepassxc-browser@keepassxc.org" = {
      installation_mode = "normal_installed";
      install_url = "https://addons.mozilla.org/firefox/downloads/latest/keepassxc-browser/latest.xpi";
      private_browsing = true;
    };
    # bitwarden
    "{446900e4-71c2-419f-a6a7-df9c091e268b}" = {
      installation_mode = "normal_installed";
      install_url = "https://addons.mozilla.org/firefox/downloads/latest/bitwarden-password-manager/latest.xpi";
      private_browsing = true;
    };
  };

  ## Preferences
  Preferences = {
    "browser.aboutConfig.showWarning" = false;
    "toolkit.legacyUserProfileCustomizations.stylesheets" = true;

    # ai
    "browser.ai.control.default" = "blocked";

    # crash reports
    "browser.tabs.crashReporting.sendReport" = false;
    "browser.crashReports.unsubmittedCheck.autoSubmit2" = false;

    "browser.newtabpage.activity-stream.feeds.telemetry" = false;
    "browser.newtabpage.activity-stream.telemetry" = false;
    "browser.newtabpage.activity-stream.showSponsoredCheckboxes" = false;
    "browser.newtabpage.activity-stream.default.sites" = false;
    "browser.urlbar.showSearchTerms.enabled" = false;

    # settings : address bar
    "browser.urlbar.quicksuggest.enabled" = false;
    "browser.urlbar.suggest.quicksuggest.nonsponsored" = false;
    "browser.urlbar.suggest.quicksuggest.sponsored" = false;
    "browser.urlbar.suggest.history" = false;
    "browser.urlbar.suggest.bookmark" = false;
    "browser.urlbar.suggest.openpage" = false;
    "browser.urlbar.suggest.topsites" = false;
    "browser.urlbar.suggest.recentsearches" = false;
    "browser.urlbar.suggest.engines" = false;
    "browser.urlbar.suggest.quickactions" = false;

    # search shortcuts
    "browser.urlbar.shortcuts.bookmarks" = false;
    "browser.urlbar.shortcuts.history" = false;
    "browser.urlbar.shortcuts.tabs" = false;

    # privacy
    "browser.formfill.enable" = false;
    "extensions.formautofill.creditCards.enabled" = false;
    "extensions.formautofill.addresses.enabled" = false;

    # password
    "signon.autofillForms" = false;
    "signon.formlessCapture.enabled" = false;

    # geolocation
    "geo.provider.ms-windows-location" = false;
    "geo.provider.use_corelocation" = false;
    "geo.provider.use_geoclue" = false;

    ## addons
    "browser.discovery.enabled" = false;
    "extensions.getAddons.showPane" = false;
    "extensions.htmlaboutaddons.recommendations.enabled" = false;
  };
}
