{
  self,
  lib,
  bash,
  treefmt,
  nixfmt,
  deadnix,
  statix,
}:

treefmt.withConfig {
  runtimeInputs = [
    nixfmt
    deadnix
    statix
  ];

  settings = {
    tree-root-file = "${self}/flake.nix";
    on-unmatched = "info";

    formatter = {
      nixfmt = {
        command = "nixfmt";
        includes = [ "*.nix" ];
      };

      deadnix = {
        command = "deadnix";
        includes = [ "*.nix" ];
        options = [
          "--edit"
          "--no-lambda-arg"
        ];
      };

      statix = {
        command = "${lib.getExe bash}";
        includes = [ "*.nix" ];
        options = [
          "-euc"
          ''
            for file in "$@"; do
              ${lib.getExe statix} fix --config ${self}/statix.toml "$file"
            done
          ''
          "--"
        ];
      };
    };
  };
}
