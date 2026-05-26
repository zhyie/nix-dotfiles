{ ... }:
{
  services.udiskie = {
    enable = true;
    settings = {
      program_options = {
        udisks_version = 2;
      };
    };
  };
}
