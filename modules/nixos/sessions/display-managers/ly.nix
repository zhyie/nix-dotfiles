{ config, lib, ... }:
{
  services.displayManager.ly = {
    enable = lib.mkIf (config.modules.graphical.display.manager == "ly") true;

    settings = {
      brightness_up_cmd = config.modules.backlight.commands.increase;
      brightness_down_cmd = config.modules.backlight.commands.decrease;
      battery_id = "BAT0";

      bigclock = "en";
      bigclock_seconds = true;
      clock = "%A, %B %d %Y";
      show_tty = true;

      auth_fails = 5;
      clear_password = true;
      default_input = "password";

      vi_mode = true;
      vi_default_mode = "insert";
    };
  };
}
