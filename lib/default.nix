{ ... } @ xargs:

# let
#   inherit (xargs) lib;
# in

{
  mkHost = host: cfg: import ./mkHost.nix (xargs // {
    inherit host;
    inherit (cfg) system userList moduleList stateVersion;
  });

  # mkHome = host: cfg:
  #   lib.nameValuePair (
  #     (lib.genAttrs usrsList (user:
  #       lib. () )) + "@${host}")
  #
  #   import ./mkHome.nix ( xargs // {
  #     inherit cfg;
  #   }
  # );
}
