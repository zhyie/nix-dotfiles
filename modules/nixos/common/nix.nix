{ inputs, userList, ... }:
{
  nix = {
    # Eliminating redundant copies of store paths.
    optimise.automatic = true;

    # Removing unreferenced and obsolete store paths.
    # Auto clean garbage older than two weeks.
    gc = {
      automatic = true;
      dates = "weekly";
      options = "--delete-older then 14d";
    };

    settings = {
      # Enbale eperimental features such as flakes.
      experimental-features = [
        "nix-command"
        "flakes"
      ];
      # Auto optimising nix store.
      auto-optimise-store = true;

      substituters = [
        "https://cache.nixos.org/"
        "https://nix-community.cachix.org"
      ];
      trusted-public-keys = [
        "cache.nixos.org-1:6NCHdD59X431o0gWypbMrAURkbJ16ZPMQFGspcDShjY="
        "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs="
      ];

      trusted-users = userList;
    };

    nixPath = [ "nixpkgs=${inputs.nixpkgs}" ];
  };
}
