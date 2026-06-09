{ pkgs, ... }:
{
  # Enable CUPS to print documents.
  services.printing = {
    enable = true;
    openFirewall = true;

    drivers = [
      # Backends, filters, and other software of the core CUPS distribution.
      pkgs.cups-filters

      # Browsing of remote CUPS printers.
      # pkgs.cups-browsed

      # Tools for interacting with CUPS server.
      # pkgs.cups-printers

      # Drivers for many different printers from many different vendors.
      # gutenprint
    ];
  };
}
