{ ...}:

{

  services.xserver = {

    enable = true;
    windowManager.dwm.enable = true;

    videoDrivers = [ "modesetting" ];

    deviceSection = ''
      "Option" "DRI" "2"
      "Option" "TearFree" "true"
    '';

  };

  nixpkgs.overlays = [ (self: super: {
    dwm = super.dwm.overrideAttrs (oldAttrs: {
      src = ../../../.config/dwm; }); }) ];
}
