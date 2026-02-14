# CONFIGURATIONS FOCUSES ON BROTHER PRINTERS
# AS IT IS THE ONE BEING USED CURRENTLY

{ config, lib, pkgs, ... }:

let
  ip = "192.168.1.13";
  printer = "Brother";
  model = "MFC-J200";

in {
  # Enable CUPS to print documents.
  services.printing = {
    enable = true;
    #browsing = true;
    #browsed = true;
    openFirewall = true;

    drivers = with pkgs; [
      # Backends, filters, and other software of the core CUPS distribution.
      cups-filters
      # Browsing of remote CUPS printers.
      cups-browsed
      # Tools for interacting with CUPS server.
      cups-printers

      # Drivers for many different printers from many different vendors.
      gutenprint
      # Generic drivers for more Brother printers (Proprietary drivers).
      brgenml1lpr
      brgenml1cupswrapper
    ];
  };

  # Configured printers.
  hardware.printers = {
    ensureDefaultPrinter = "Brother_" ++ model;
    # ensurePrinters = [
    #   {
    #     name = printer ++ "_" ++ model;
    #     location = "home";
    #     deviceUri = "":
    #     model = model ++ ".ppd.gz";
    #   }
    # ];
  };

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
