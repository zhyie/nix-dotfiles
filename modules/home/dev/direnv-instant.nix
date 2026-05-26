{
  config,
  lib,
  inputs,
  ...
}:
{
  imports = [ inputs.direnv-instant.homeModules.direnv-instant ];

  programs.direnv-instant.enable = lib.mkDefault config.modules.dev.enable;

  assertions =
    let
      inherit (config.programs) direnv direnv-instant;
    in
    [
      {
        assertion = !direnv-instant.enable || direnv.enable;
        message = "direnv-instant requires direnv to be enabled.";
      }
    ];
}
