{ config, lib, pkgs, ... }:

{
  nix = {
    settings = {
      # Enbale eperimental features such as flakes.
      experimental-features = [ "nix-command" "flakes" ];
      # Auto optimising nix store.
      auto-optimise-store = true;
    };

    # Auto clean generations older than 14 days.
    gc = {
      automatic = true;
      dates = "weekly";
      options = "--delete-older then 14d";
    };
  };
  
  # Enable unfree packages.
  nixpkgs.config.allowUnfree = true;
  

  # System state version.
  # system.stateVersion = "25.11";
}
