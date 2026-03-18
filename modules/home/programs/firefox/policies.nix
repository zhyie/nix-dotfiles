{
  ## General
  DontCheckDefaultBrowser = true;
  DisplayBookmarksToolbar = "newtab";
  DisplayMenuBar = "default-off";
  Homepage.StartPage = "previous-session";
  SanitizedOnShutdown = {
    Cache = true;
    Cookies = true;
    FormData = true;
    History = true;
    SiteSettings = true;
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
  FirefoxSuggest = {
    WebSuggestions = false;
    SponsoredSuggestions = false;
    ImprovedSuggest = false;
  };
  UserMessaging = {
    ExtensionRecommendations = false;
    UrlbarInterventions = false;
    SkipOnboarding = true;
    MoreFromMozilla = false;
    FirefoxLabs = true;
  };

  ## Search
  SearchBar = "unified";
  SearchSuggestEnabled = false;
  # SearchEngines = {
  #   Default = "DuckDuckGo";
  #   Remove = [
  #     "Google"
  #     "Bing"
  #     "eBay"
  #     "Perplexity"
  #     "Wikipedia"
  #   ];
  # Add = [
  #   {
  #     "Name" = "DuckDuckGo";
  #     "URLTemplate" = "https://duckduckgo.com/?q={searchTerms}";
  #     "IconURL" = "https://duckduckgo.com/favicon.ico";
  #     "Alias" = "ddg";
  #   }
  #   {
  #     "Name" = "Startpage";
  #     "URLTemplate" = "https://www.startpage.com/sp/search?query={searchTerms}";
  #     "IconURL" = "https://www.startpage.com/favicon.ico";
  #     "Alias" = "sp";
  #   }
  # ];
  # };

  ## Privacy and Security
  PasswordManagerEnabled = false;
  EnableTrackingProtection = {
    Value = true;
    Locked = true;
    Cryptomining = true;
    Fingerprinting = true;
  };
  HttpsOnlyMode = "enabled";
  DNSOverHTTPS = {
    Enabled = true;
    ProviderURL = " https://sky.rethinkdns.com/1:AAoACAgA";
    Fallback = true;
  };
  Permissions = {
    Camera.BlockNewRequests = true;
    Microphone.BlockNewRequests = true;
    Location.BlockNewRequests = true;
    Notification.BlockNewRequests = true;
    Autoplay.Default = "block-audio";
    VirtualReality.BlockNewRequests = true;
    ScreenShare.BlockNewRequests = true;
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
  "3rdParty" = {
    Extensions = {
      "uBlock0@raymondhill.net".adminSettings = builtins.readFile ./ublock.txt;
    };
  };
  ExtensionSettings = {
    # ublock origin
    "uBlock0@raymondhill.net" = {
      installation_mode = "force_installed";
      install_url = "https://addons.mozilla.org/firefox/downloads/latest/ublock-origin/latest.xpi";
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
  Preferences = import ./preferences.nix;
}
