{
  config,
  lib,
  pkgs,
  ...
}:
{
  options.modules.nixos.backlight = {
    step = lib.mkOption {
      type = lib.types.int;
      default = 5;
      description = ''
        The percentage value by which to increase/decrease brightness.
      '';
    };

    min = lib.mkOption {
      type = lib.types.numbers.between 0 100;
      default = 0.1;
      description = ''
        The minimum authorized brightness value, e.g. to avoid the
        display going dark.
      '';
    };
    upKey = lib.mkOption {
      type = lib.types.ints.unsigned;
      description = ''
        Key code for increasing screen brightness.
      '';
    };
    downKey = lib.mkOption {
      type = lib.types.ints.unsigned;
      description = ''
        Key code for decreasing screen brightness.
      '';
    };
  };

  config = {
    # Enable backlight.
    programs.light.enable = true;
    services.actkbd = {
      enable = true;
      bindings =
        let
          cfg = config.modules.nixos.backlight;
          light = "${pkgs.light}/bin/light";
          step = toString cfg.step;
          min = toString cfg.min;
        in
        [
          # brightness down
          # -N set minimum brightness
          {
            # keys = [ 232 ];
            # keys = cfg.downKey;
            keys = [ cfg.downKey ];
            events = [ "key" ];
            command = "${light} -N ${min} && ${light} -U ${step}";
          }
          # brightness up
          {
            # keys = [ 233 ];
            # keys = cfg.upKey;
            keys = [ cfg.upKey ];
            events = [ "key" ];
            command = "${light} -A ${step}";
          }
        ];
    };
  };
}
