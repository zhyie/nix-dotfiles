{ pkgs, ... }:

{
  # Enable to control backlight
  programs.light = {
    enable = true;
    # brightnessKeys = {
    #   enable = true;
    #   step = 5; # percent light value
    #   minBrightness = 5; # integer or float, between 0 and 100
    # };
  };

  # Install actkbd packages
  environment.systemPackages = with pkgs; [ actkbd ];

  # Configure keybinds
  services.actkbd = let
    volStep = "5%";
    maxVol = "1.0";
    lightStep = "5";
    minLight = "5";

    setMaxVol = "-l ${maxVol}";
    setMinLight = "light -N ${minLight}";
  in {
    enable = true;

    bindings = [
      # Raise volume
      {
        keys = [ 123 ];
        events = [ "key" ];
        command = "wpctl set-volume @DEFAULT_AUDIO_SINK@ ${volStep}+ ${setMaxVol}";
      }
      # Lower volume
      {
        keys = [ 122 ];
        events = [ "key" ];
        command = "wpctl set-volume @DEFAULT_AUDIO_SINK@ ${volStep}-";
      }
      # Mute volume
      {
        keys = [ 121 ];
        events = [ "key" ];
        command = "wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle";
      }
      # Mute mic
      {
        keys = [ 198 ];
        events = [ "key" ];
        command = "wpctl set-mute @DEFAULT_AUDIO_SOURCE@ toggle";
      }

      # Bright up
      {
        keys = [ 233 ];
        events = [ "key" ];
        command = "light -A ${lightStep}";
      }
      # Bright down
      {
        keys = [ 232 ];
        events = [ "key" ];
        command = "${setMinLight} && light -U ${lightStep}";
      }
      # # Bright up
      # {
      #   keys = [ 233 ];
      #   events = [ "key" ];
      #   command = "light -N {} -A ${lightStep}";
      # }
      # # Bright down
      # {
      #   keys = [ 232 ];
      #   events = [ "key" ];
      #   command = "light -U ${lightStep}";
      # }
    ];

  };
}
