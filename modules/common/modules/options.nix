{ lib, ... }:
{
  options.modules =
    let
      inherit (lib)
        mkEnableOption
        mkOption
        types
        genAttrs
        ;
      inherit (types) listOf str lines;

      moduleList = [
        "desktop"
        "laptop"
        "dev"
        "gaming"
        "xserver"
        "wayland"
        "flatpak"
        "shell"
        "themes"
      ];

      mkEnable = name: { enable = mkEnableOption "Enable ${name} modules."; };
    in
    genAttrs moduleList mkEnable
    // {
      shell.beforeExec = mkOption {
        type = lines;
        default = "";
        description = "Commands to run before an exec of shell.";
      };

      flatpak.packages = mkOption {
        type = listOf str;
        default = [ ];
        description = "Flatpak packages to install.";
      };
    };
}
