{config, pkgs, ... }:

{

  # For configuring brightness control keys
  programs.light.enable = true;

  # Install actkbd packages
  environment.systemPackages = with pkgs; [ actkbd ];

  # Configure keyboards
  services.actkbd = let volStep = "5%"; lightStep = "10"; in
  {
    enable = true;

    bindings = [
      # Raise volume
      {
	keys = [ 123 ];
	events = [ "key" ];
	command = "/run/current-system/sw/bin/wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%+";
      }
      # Lower volume
      {
        keys = [ 122 ];
	events = [ "key" ];
	command = "wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-";
      }
      # Mute volume
      {
        keys = [ 121 ];
	events = [ "key" ];
	command = "/run/current-system/sw/bin/wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle";
      }
      # Mute mic
      { 
        keys = [ 198 ];
	events = [ "key" ];
	command = "/run/current-system/sw/bin/wpctl set-mute @DEFAULT_AUDIO_SOURCE@ toggle";
      }

      # Bright up
      {
        keys = [ 233 ];
	events = [ "key" ];
	command = "/run/wrappers/bin/light -A ${lightStep}";
      }
      # Bright down
      { 
        keys = [ 232 ];
	events = [ "key" ];
	command = "/run/wrappers/bin/light -U ${lightStep}";
      }
    ];

  };

}
