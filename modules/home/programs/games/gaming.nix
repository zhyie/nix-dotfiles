{
  config,
  lib,
  inputs,
  ...
}:
{
  imports = [ inputs.self.modules.common.gaming ];

  config =
    let
      inherit (lib)
        mkIf
        ;
      cfg = config.modules.gaming;
    in
    mkIf (cfg.env == "home") { home.packages = cfg.packages.nixpkgs; };
}
