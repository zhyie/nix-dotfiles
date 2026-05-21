{ config, lib, ... }:
{
  options.modules.nixos.tlp = {
    settings = lib.mkOption {
      type = lib.types.attrsOf (
        lib.types.oneOf [
          lib.types.bool
          lib.types.int
          lib.types.float
          lib.types.str
          (lib.types.listOf lib.types.str)
        ]
      );
      description = ''
        Options passed to TLP. See <https://linrunner.de/tlp> for all supported options.
      '';
      default = {
        CPU_SCALING_GOVERNOR_ON_AC = "performance";
        CPU_SCALING_GOVERNOR_ON_BAT = "powersave";

        CPU_ENERGY_PERF_POLICY_ON_AC = "performance";
        CPU_ENERGY_PERF_POLICY_ON_BAT = "balance_power";

        CPU_MIN_PERF_ON_AC = 0;
        CPU_MAX_PERF_ON_AC = 100;
        CPU_MIN_PERF_ON_BAT = 0;
        CPU_MAX_PERF_ON_BAT = 60;

        # Laptop runs hot when on power but not on battery
        # This tells tlp to always run in battery mode
        TLP_DEFAULT_MODE = "BAT";
        TLP_PERSISTENT_DEFAULT = 1;
      };
    };
  };

  # Performance scaling
  config = {
    services.tlp = {
      enable = true;
      settings = config.modules.nixos.tlp.settings;
    };
  };
}
