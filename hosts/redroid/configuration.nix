{ hostConfig, ... }:
{
  #: Packages to install to path.
  environment.packages = [ ];

  #######################################
  #   OFF LIMIT  SYSTEM STATE VERSION   #
  #######################################
  system = {
    inherit (hostConfig) stateVersion;
  };
}
