{
  inputs,
  formats,
  writeShellScriptBin,

  treefmt,
  nixfmt,
  deadnix,
  statix,
}:
let
  toml = formats.toml { };

  statixConfig = toml.generate "statix.toml" {
    disbaled = [
      "manual_inherit_from"
      "empty_pattern"
      "redundant_pattern_bind"
      "repeated_keys"
    ];
  };

  statixFix = writeShellScriptBin "statix-fix" ''
    for file in "$@"; do
      ${statix}/bin/statix fix --config ${statixConfig} -- "$file"
    done
  '';
in
treefmt.withConfig {
  runtimeInputs = [
    nixfmt
    deadnix
    statixFix
  ];

  settings = {
    tree-root-file = "${inputs.self}/flake.nix";
    on-unmatched = "info";

    excludes = [
      "hosts/elitenix/hardware-configuration.nix"
      "dotfiles/**"
      "secrets/**"
    ];

    formatter = {
      nixfmt = {
        command = "nixfmt";
        includes = [ "*.nix" ];
      };

      deadnix = {
        command = "deadnix";
        options = [
          "--edit"
          "--no-lambda-arg"
        ];
        includes = [ "*.nix" ];
      };

      statix = {
        command = "statix-fix";
        includes = [ "*.nix" ];
      };
    };
  };
}
