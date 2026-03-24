{
  config,
  pkgs,
  inputs,
  ...
}:
{
  # home.file.".mozilla/firefox/profile2/chrome/userChrome.css" = {
  home.file.".mozilla/firefox/profile2/chrome" = {
    source =
      let
        inherit (config.lib.file) mkOutOfStoreSymlink;
        inherit (config.home) homeDirectory;
      in
      mkOutOfStoreSymlink (homeDirectory + "/.os/dotfiles/firefox/chrome");
  };

  programs.firefox = {
    enable = true;
    languagePacks = [
      "en-US"
      "tl"
    ];

    ## POLICIES
    policies = import ./policies.nix { inherit inputs; };

    ## Bare profile
    profiles.profile1 = {
      id = 1;
      name = "Profile 1";
    };

    ## Customized profile
    profiles.profile2 = {
      id = 0;
      name = "Profile 2";
      # userChrome = builtins.readFile (inputs.dotfiles + "/firefox/chrome/userChrome.css");
      settings = {
        "places.history.enabled" = false;
        "privacy.clearSiteData.browsingHistoryAndDownloads" = true;
        "privacy.clearSiteData.cookiesAndStorage" = true;
        "privacy.clearSiteData.cache" = true;
        "privacy.clearSiteData.formdata" = true;
        "privacy.clearSiteData.siteSettings" = true;
        "privacy.clearHistory.browsingHistoryAndDownloads" = true;
        "privacy.clearHistory.cookiesAndStorage" = true;
        "privacy.clearHistory.cache" = true;
        "privacy.clearHistory.formdata" = true;
        "privacy.clearHistory.siteSettings" = true;
      };
      search.engines =
        let
          icon = "${pkgs.nixos-icons}/share/icons/hicolor/scalable/apps/nix-snowflake.svg";
        in
        {
          "Nix Packages" = {
            inherit icon;
            definedAliases = [ "@np" ];
            urls = [
              {
                template = "https://search.nixos.org/packages";
                params = [
                  {
                    name = "channel";
                    value = "unstable";
                  }
                  {
                    name = "query";
                    value = "{searchTerms}";
                  }
                ];
              }
            ];
            # icon = "${pkgs.nixos-icons}/share/icons/hicolor/scalable/apps/nix-snowflake.svg";
          };

          "Nix Options" = {
            inherit icon;
            definedAliases = [ "@no" ];
            urls = [
              {
                template = "https://search.nixos.org/options";
                params = [
                  {
                    name = "channel";
                    value = "unstable";
                  }
                  {
                    name = "query";
                    value = "{searchTerms}";
                  }
                ];
              }
            ];
            # icon = "${pkgs.nixos-icons}/share/icons/hicolor/scalable/apps/nix-snowflake.svg";
          };

          "NixOS Wiki" = {
            inherit icon;
            definedAliases = [ "@nw" ];
            urls = [
              {
                template = "https://wiki.nixos.org/w/index.php";
                params = [
                  {
                    name = "search";
                    value = "{searchTerms}";
                  }
                ];
              }
            ];
            # icon = "${pkgs.nixos-icons}/share/icons/hicolor/scalable/apps/nix-snowflake.svg";
          };

          "Home Manager" = {
            inherit icon;
            definedAliases = [ "@hm" ];
            urls = [
              {
                template = "https://home-manager-options.extranix.com";
                params = [
                  {
                    name = "query";
                    value = "{searchTerms}";
                  }
                  {
                    name = "release";
                    value = "master";
                  }
                ];
              }
            ];
            # icon = "${pkgs.nixos-icons}/share/icons/hicolor/scalable/apps/nix-snowflake.svg";
          };

          "Noogle" = {
            inherit icon;
            definedAliases = [ "@ng" ];
            urls = [
              {
                template = "https://noogle.dev/q";
                params = [
                  {
                    name = "term";
                    value = "{searchTerms}";
                  }
                ];
              }
            ];
            # icon = "${pkgs.nixos-icons}/share/icons/hicolor/scalable/apps/nix-snowflake.svg";
          };
        };
    };
  };
}
