{
  services.displayManager.ly = {
    enable = true;

    settings = {
      # brightness_down_cmd = "${pkgs.light/bin/light} -U 10";
      # brightness_up_cmd = "${pkgs.light/bin/light} -A 10";
      battery_id = "BAT0";

      auth_fails = 3;
      clear_password = true;
      default_input = "password";
      blank_box = false;

      bigclock = "none";
      bigclock_seconds = true;

      clock = "%a, %b %d %H:%M:%S";
      hide_borders = true;
      show_tty = true;
      vi_mode = true;

      animation = "gameoflife";
    };
  };
}
