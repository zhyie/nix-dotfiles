{
  config,
  lib,
  pkgs,
  ...
}:
{
  options.modules.backlight =
    let
      inherit (lib)
        mkEnableOption
        mkPackageOption
        mkOption
        types
        ;
    in
    {
      enable = mkEnableOption "Enable brightness control.";
      package = mkPackageOption pkgs "brightnessctl" { };

      step = mkOption {
        type = types.int;
        default = 5;
        description = "The step value by which to increase/decrease brightness.";
      };

      minimum = mkOption {
        type = types.numbers.between 0 100;
        default = 5;
        description = "The minimum brightness value to avoid the display going dark.";
      };

      keycodes = {
        increase = mkOption {
          type = types.ints.unsigned;
          description = "Key code for increasing screen brightness.";
        };
        decrease = mkOption {
          type = types.ints.unsigned;
          description = "Key code for decreasing screen brightness.";
        };
      };

      flags = {
        minimum = mkOption {
          type = types.str;
          description = "Flag to pass to set minimum brightness.";
        };
        increase = mkOption {
          type = types.str;
          description = "Flag to pass to increase brightness.";
        };
        decrease = mkOption {
          type = types.str;
          description = "Flag to pass to decrease brightness.";
        };
      };

      commands = {
        increase = mkOption {
          type = types.lines;
          description = "Command to increase brightness.";
        };
        decrease = mkOption {
          type = types.lines;
          description = "Command to decrease brightness.";
        };
      };
    };

  config =
    let
      cfg = config.modules.backlight;
    in
    {
      environment.systemPackages = [ cfg.package ];

      modules.backlight.commands =
        let
          cmd = lib.getExe cfg.package;
          step = toString cfg.step;
          minimum = toString cfg.minimum;

          flagMin = cfg.flags.minimum;
          flagInc = cfg.flags.increase;
          flagDec = cfg.flags.decrease;
        in
        {
          increase = "${cmd} ${flagInc} ${step}%+";
          decrease = "${cmd} ${flagMin} ${minimum} && ${cmd} ${flagDec} ${step}%-";
        };

      #: Keybinds of function keys for
      #: controliing screen brightness
      services.actkbd = {
        enable = true;

        bindings = [
          #: Increase screen brightness
          {
            keys = [ cfg.keycodes.increase ];
            events = [ "key" ];
            # command = "${cmd} ${flagInc} ${step}%+";
            command = cfg.commands.increase;
          }

          #: Decrease screen brightness
          #: `-N` flag set the minimum brightness
          {
            keys = [ cfg.keycodes.decrease ];
            events = [ "key" ];
            # command = "${cmd} ${flagMin} ${minimum} && ${cmd} ${flagDec} ${step}%-";
            command = cfg.commands.decrease;
          }
        ];
      };
    };
}
