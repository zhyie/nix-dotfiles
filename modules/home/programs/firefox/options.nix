{ lib, ... }:
{
  options.modules.home.firefox = {
    enable = lib.mkDefault "Firefox home modules";
    profiles = lib.mkOption {
      type = lib.types.either (lib.types.listOf lib.types.str) (
        lib.types.enum [
          1
          2
        ]
      );
    };
  };
}
