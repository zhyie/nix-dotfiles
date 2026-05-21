{ inputs, pkgs }:

let
  inherit (pkgs.lib) mapAttrs;
  inherit (pkgs.stdenv.hostPlatform) system;
  # inherit (inputs.self) nixosConfigurations;
  inherit (inputs.self) nixosConfigurations homeConfigurations;
in
{
  formatter =
    pkgs.runCommandLocal "fmt-check"
      {
        nativeBuildInputs = [ inputs.self.formatter.${system} ];
      }
      ''
        treefmt --no-cache

        touch $out
      '';
}
// mapAttrs (h: _: nixosConfigurations.${h}.config.system.build.toplevel) nixosConfigurations
// mapAttrs (h: _: homeConfigurations.${h}.activationPackage) homeConfigurations
