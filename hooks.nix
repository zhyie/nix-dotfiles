{ pkgs, inputs }:

inputs.git-hooks.lib.${pkgs.stdenv.hostPlatform.system}.run {
  src = ./.;
  # package = pkgs.prek;

  excludes = [
    "^hosts/.*/hardware-configuration.nix$"
    "^dotfiles/.*"
    "^secrets/.*"
  ];

  hooks = {
    nixfmt.enable = true;

    deadnix = {
      enable = true;
      settings = {
        edit = true;
        noLambdaPatternNames = true;
      };
    };

    statix = {
      enable = true;
      settings.config = "${pkgs.writeText "statix.toml" ''
        disabled = [
          "manual_inherit_from",
          "empty_pattern",
          "redundant_pattern_bind",
          "repeated_keys",
        ]
      ''}";

      # name = "statix-fix";
      # package = pkgs.statix;
      # files = "\\.nix$";
      # pass_filenames = false;
      # entry = "${pkgs.statix}/bin/statix fix -c ${pkgs.writeText "statix.toml" ''
      #   disabled = [
      #     "manual_inherit_from",
      #     "empty_pattern",
      #     "redundant_pattern_bind",
      #     "repeated_keys",
      #   ]
      # ''}";
    };
  };
}
