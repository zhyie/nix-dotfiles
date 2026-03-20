{ pkgs, inputs, ... }:
{
  # home.file.".mozilla/profile1/chrome" = {
  #   source = inputs.dotfiles + "/firefox/cascade";
  # };

  programs.firefox = {
    enable = true;
    languagePacks = [
      "en-US"
      "tl"
    ];

    ## POLICIES
    policies = import ./policies.nix { inherit inputs; };

    ## PROFILES
    profiles = {
      ## secondary profile
      profile2 = {
        id = 1;
        name = "profile2";
        search = {
          default = "ddg";
          privateDefault = "ddg";
        };
      };

      ## default
      profile1 = {
        id = 0;
        name = "profile1";
        userChrome = builtins.readFile (inputs.dotfiles + "/firefox/userChrome.css");
        settings = {
          "browser.startup.page" = 3;
          "privacy.clearSiteData.cookiesAndStorage" = true;
          "privacy.clearHistory.cookiesAndStorage" = true;
          "places.history.enabled" = false;
          "privacy.clearSiteData.cache" = true;
          "privacy.clearSiteData.formdata" = true;
          "privacy.clearHistory.cache" = true;
          "privacy.clearHistory.formdata" = true;
          # "privacy.window.maxInnerWidth" = 1920;
          # "privacy.window.maxInnerHeight" = 1080;
          # "privacy.resistFingerprinting.block_mozAddonManager" = true;
        };
        search = {
          default = "sp";
          engines = {
            "Nix Packages" = {
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
              icon = "${pkgs.nixos-icons}/share/icons/hicolor/scalable/apps/nix-snowflake.svg";
              definedAliases = [ "@np" ];
            };

            "Nix Options" = {
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
              icon = "${pkgs.nixos-icons}/share/icons/hicolor/scalable/apps/nix-snowflake.svg";
              definedAliases = [ "@no" ];
            };

            "NixOS Wiki" = {
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
              icon = "${pkgs.nixos-icons}/share/icons/hicolor/scalable/apps/nix-snowflake.svg";
              definedAliases = [ "@nw" ];
            };

            "Home Manager" = {
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
              icon = "${pkgs.nixos-icons}/share/icons/hicolor/scalable/apps/nix-snowflake.svg";
              definedAliases = [ "@hm" ];
            };
          };
        };
      };
    };
  };
}
