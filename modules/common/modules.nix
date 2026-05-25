{ lib, ... }:

let
  inherit (lib)
    mkEnableOption
    mkOption
    types
    genAttrs
    ;
  inherit (types) lines;

  moduleList = [
    "desktop"
    "laptop"
    "dev"
    "gaming"
    "graphical"
    "xserver"
    "wayland"
    "shell"
    "themes"
  ];

  mkEnable = name: { enable = mkEnableOption "Enable ${name} modules."; };
in
{
  options.modules = genAttrs moduleList mkEnable // {
    shell.beforeExec = mkOption {
      type = lines;
      default = "";
      description = "Commands to run before an exec of shell.";
    };
  };

  # options.modules = lib.mkOption {
  #   type = lib.types.attrsOf (
  #     lib.types.submodule (
  #       { name, ... }:
  #       {
  #         enable = mkEnableOption "Enable ${name} modules.";
  #       }
  #     )
  #   );
  #   default = { };
  #   description = "Modules options.";
  # };
}
