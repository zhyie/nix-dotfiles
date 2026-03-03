{ ... } @ xinherits:

# let
#   inherit (xinherits) lib;
# in

{
  mkHost = host: cfg: import ./mkHost.nix (xinherits // {
    inherit host;
    inherit (cfg) system userList moduleList stateVersion;
  });

  # mkHome = host: cfg:
  #   lib.nameValuePair (
  #     (lib.genAttrs usrsList (user:
  #       lib. () )) + "@${host}")
  #
  #   import ./mkHome.nix ( xinherits // {
  #     inherit cfg;
  #   }
  # );
}
