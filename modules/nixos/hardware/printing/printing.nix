{ pkgs, ... }:
{
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
}
