{ lib, ... }:

let
  inherit (lib) genAttrs;

  moduleList = [
    "desktop"
    "laptop"
    "dev"
    "gaming"
    "graphical"
    "xserver"
    "wayland"
  ];

  mkEnable = name: { enable = lib.mkEnableOption "Enable ${name} modules."; };
in
{
  options = {
    modules = genAttrs moduleList mkEnable // {
      shell.beforeExec = lib.mkOption {
        type = lib.types.lines;
        default = "";
        description = "Commands to run before an exec of shell.";
      };
    };

    listModules = lib.mkOption {
      type = lib.types.listOf lib.types.str;
      default = [ ];
      example = lib.literalExpression ''
        listModules = [
          "bash"
          "neovim"
        ];
      '';
      description = ''
        List of pre-configured modules to enable.
      '';
    };

    enableModules = lib.mkOption {
      type = lib.types.attrsOf lib.types.bool;
      default = { };
      example = lib.literalExpression ''
        enableModules = {
          bash = true;
          neovim = true;
        };
      '';
      description = ''
        Attr of pre-configured modules to enable.
      '';
    };
  };
}
