{
  config,
  lib,
  pkgs,
  ...
}:
{
  options.modules.nixos.light = {
    step = lib.mkOption {
      type = lib.types.int;
      default = 5;
      description = ''
        The percentage value by which to increase/decrease brightness.
      '';
    };

    minimum = lib.mkOption {
      type = lib.types.numbers.between 0 100;
      default = 0.1;
      description = ''
        The minimum authorized brightness value, e.g. to avoid the
        display going dark.
      '';
    };

    keys = {
      increase = lib.mkOption {
        type = lib.types.ints.unsigned;
        description = ''
          Key code for increasing screen brightness.
        '';
      };
      decrease = lib.mkOption {
        type = lib.types.ints.unsigned;
        description = ''
          Key code for decreasing screen brightness.
        '';
      };
    };
  };

  config = {
    #: Enable backlight.
    programs.light.enable = true;

    #: Keybinds of function keys for
    #: controliing screen brightness
    services.actkbd = {
      enable = true;
      bindings =
        let
          cfg = config.modules.nixos.light;
          light = lib.getExe pkgs.light;
          step = toString cfg.step;
          minimum = toString cfg.minimum;
        in
        [
          #: Decrease screen brightness
          #: `-N` flag set the minimum brightness
          {
            keys = [ cfg.keys.decrease ];
            events = [ "key" ];
            command = "${light} -N ${minimum} && ${light} -U ${step}";
          }
          #: Increase screen brightness
          {
            keys = [ cfg.keys.increase ];
            events = [ "key" ];
            command = "${light} -A ${step}";
          }
        ];
    };
  };
}
