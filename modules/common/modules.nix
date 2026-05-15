{ lib, ... }:
{
  options.modules =
    let
      inherit (lib) mkEnableOption genAttrs;

      moduleList = [
        "flatpak"
        "gaming"
        "dev"
      ];

      mkEnable = name: { enable = mkEnableOption "Enable ${name} modules."; };
    in
    genAttrs moduleList mkEnable;
}
