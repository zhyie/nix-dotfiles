{ pkgs, ... }:

let
  printer = "Brother";
  model = "MFC-J200";
in
{
  imports = [
    ./printing.nix
    ./scanner.nix
  ];

  services.printing.drivers = [
    pkgs.brgenml1lpr
    pkgs.brgenml1cupswrapper
  ];

  # hardware = {
  #   printers.ensurePrinters = [
  #     {
  #       name = "${printer}_${model}";
  #       # model = "";
  #       # deviceUri = "";
  #       description = "Home printer," + "${printer} ${model}";
  #       location = "Home";
  #     }
  #   ];

  #   sane.brscan4 = {
  #     enable = true;
  #     netDevices.home = {
  #       name = "${printer}_${model}";
  #       model = model;
  #       # ip = "";
  #     };
  #   };
  # };
}
