{
  lib,
  inputs,
  hostConfig,
  ...
}:
{
  nix =
    let
      flakeInputs = lib.filterAttrs (_: lib.isType "flake") inputs;
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

        #: Jobs and cores for builds.
        max-jobs = 2;
        cores = 4;

        #: URLs and public keys of binary caches.
        #: Give additional rights to users such as
        #: ability to specify additional binary caches.
        substituters = [
          "https://cache.nixos.org/"
          "https://nix-community.cachix.org"
        ];
        trusted-public-keys = [
          "cache.nixos.org-1:6NCHdD59X431o0gWypbMrAURkbJ16ZPMQFGspcDShjY="
          "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs="
        ];
        trusted-users = hostConfig.users;

        #: Bump download size buffer to 500MB
        download-buffer-size = 524288000;

        #: Empty the path of global flake registry.
        flake-registry = "";

        #: Keep the outputs of non-garbage derivations.
        keep-outputs = true;

        #: Disable warn about dirty Git trees.
        warn-dirty = false;

        #: Nix will conform to the XDG Base Directory Specification.
        use-xdg-base-directories = true;
      };

      #: Flake registries.
      registry = lib.mapAttrs (_: flake: { inherit flake; }) flakeInputs;

      #: Nix expression search path.
      nixPath = lib.mapAttrsToList (n: _: "${n}=flake:${n}") flakeInputs;

      #: Disable the use of nix channel.
      channel.enable = false;
    };

  #: Nixpkgs configurations.
  nixpkgs = {
    config = {
      allowUnfree = true;
      allowUnfreePredicate = _: true;
      permittedInsecurePackages = [
        "intel-media-sdk-23.2.2"
      ];
    };

    #: Overlays to apply to Nixpkgs.
    overlays = lib.attrValues inputs.self.overlays;
  };
}
