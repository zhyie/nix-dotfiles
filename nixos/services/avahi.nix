{ pkgs, ... }:

{
  services.avahi = {
    enable = true;
    package = pkgs.avahi;
    nssmdns4 = true;
    openFirewall = true;
    publish = {
      enable = true;
      userServices = true;
    };
  };
}
