{ hostConfig, ... }:
{
  #: Packages to install to path.
  environment.packages = [ ];

  #######################################
  #   OFF LIMIT  SYSTEM STATE VERSION   #
  #######################################
  #: Do NOT change, unless all the changes
  #: it would make to a configuration have
  #: been manually inspected and the data
  #: is migrated accordingly.
  system = {
    inherit (hostConfig) stateVersion;
  };
  #: Read the changelog accordingly:
  #: https://github.com/nix-community/nix-on-droid
}
