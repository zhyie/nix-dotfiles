{
  lib,
  inputs,
  hostConfig,
  ...
}:
{
  nix =
    let
      inherit (lib)
        filterAttrs
        isType
        mapAttrs
        mapAttrsToList
        ;
      flakeInputs = filterAttrs (_: isType "flake") inputs;
    in
    {
      #: Eliminating redundant copies of store paths.
      optimise.automatic = true;

      #: Removing unreferenced and obsolete store paths.
      #: Auto clean garbage older than two weeks.
      gc = {
        automatic = true;
        dates = "weekly";
        options = "--delete-older then 14d";
      };

      settings = {
        #: Enable experimental features such as flakes.
        experimental-features = [
          "nix-command"
          "flakes"
        ];

        #: Auto optimising nix store.
        auto-optimise-store = true;

        #: Jobs and cores for builds
        max-jobs = 2;
        cores = 4;

        #: Binary caches
        substituters = [
          "https://cache.nixos.org/"
          "https://nix-community.cachix.org"
        ];
        trusted-public-keys = [
          "cache.nixos.org-1:6NCHdD59X431o0gWypbMrAURkbJ16ZPMQFGspcDShjY="
          "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs="
        ];
        trusted-users = hostConfig.userList;
      };

      #: Flake registry
      registry = mapAttrs (_: flake: { inherit flake; }) flakeInputs;
      #: Nix expression search path
      nixPath = mapAttrsToList (n: _: "${n}=flake:${n}") flakeInputs;
      # nixPath = [ "nixpkgs=${inputs.nixpkgs}" ];

      #: Disable nix channels.
      channel.enable = false;
    };

  #: Nixpkgs configs.
  nixpkgs = {
    config = {
      allowUnfree = true;
      allowUnfreePredicate = p: true;
      permittedInsecurePackages = [
        "intel-media-sdk-23.2.2"
      ];
    };

    #: nixpkgs overlays
    overlays = builtins.attrValues inputs.self.overlays;
  };
}
