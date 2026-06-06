{ ... }:

let
  model = "MFC-J200";
in
{
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
}
