{ ... }:

# let
#   printer = "Epson";
#   model = "L3210";
# in
{
  imports = [
    ./printing.nix
    ./scanner.nix
  ];

  # services.printing.drivers = [ pkgs.epson-escpr ];

  # hardware = {
  #   printers.ensurePrinters = [
  #     {
  #       name = "${printer}_${model}";
  #       model = "";
  #       description = "${printer} ${model}";
  #       deviceUri = "usb://EPSON/L3210%20Series?serial=5841474D3337313280";
  #       location = "Home";
  #     }
  #   ];

  #   sane.extraBackends = [ pkgs.epsonscan2 ];
  # };
}
