{ ... }:
{
  # Enable support for scanner.
  hardware.sane = {
    enable = true;
    openFirewall = true;

    # brscan5 = {
    #   enable = true;
    #   netDevices = {
    #     home = { model = model; ip = ip; };
    #   };
    #   extraBackends = [ pkgs.brscan5 ];
    # };
  };
}
