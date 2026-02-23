{ config, inputs, ... }:

{
  nix = {
    settings = {
      # Enbale eperimental features such as flakes.
      experimental-features = [ "nix-command" "flakes" ];
      # Auto optimising nix store.
      auto-optimise-store = true;
    };

    # Eliminating redundant copies of store paths.
    optimise.automatic = true;

    # Removing unreferenced and obsolete store paths.
    # Auto clean garbage older than two weeks.
    gc = {
      automatic = true;
      dates = "weekly";
      options = "--delete-older then 14d";
    };

    nixPath = [ "nixpkgs=${inputs.nixpkgs}" ];
  };

  # Enable unfree packages.
  nixpkgs.config.allowUnfree = true;


  # System state version.
  # system.stateVersion = "25.11";
}
