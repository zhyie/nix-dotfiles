{ lib, ... }:

let
  moduleList = [
    "desktop"
    "laptop"
    "dev"
    "gaming"
    "graphical"
    "xserver"
    "wayland"
  ];
in
{
  options.modules =
    lib.genAttrs moduleList (name: {
      enable = lib.mkEnableOption "Enable ${name} modules.";
    })
    // {
      list = lib.mkOption {
        type = lib.types.listOf lib.types.str;
        default = [ ];
        description = "List of pre-configured modules to enable.";
      };
    };
}
