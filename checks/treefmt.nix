{
  projectRootFile = "flake.nix";

  programs = {
    nixfmt.enable = true;
    deadnix = {
      enable = true;
      no-lambda-arg = true;
    };
    statix = {
      enable = true;
      disabled-lints = [
        "empty_pattern"
        "redundant_pattern_bind"
        "repeated_keys"
      ];
    };
  };

  settings.excludes = [
    "hosts/**/hardware-configuration.nix"
    "dotfiles/**"
    "secrets/**"
  ];
}
