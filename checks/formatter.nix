{
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
    tree-root-file = "flake.nix";
    on-unmatched = "info";

    excludes = [
      "hosts/**/hardware-configuration.nix"
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
        includes = [ "*.nix" ];
      };
      statix = {
        command = "statix";
        includes = [ "*.nix" ];
      };
    };
  };
}
