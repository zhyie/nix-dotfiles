{ inputs, nixpkgs, system, ... }: 

host: { hardware, extraModules ? [ ] }:

  let
  
   nixosConfig = ../hosts/${host}/configuration.nix;
   hardwareConfig = ../hosts/hardware/${hardware}.nix;
    
  in nixpkgs.lib.nixosSystem rec {
  
    inherit system;
    specialArgs = { inherit hostname };

    modules = [
      nixosConfig
      hardwareConfig
    ] ++ extraModules;
  }


