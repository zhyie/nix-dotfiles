{ ... } @ xargs:

# let
#   inherit (xargs) lib;
# in

{
  mkHost = host: cfg: import ./mkNixos.nix (xargs // {
    inherit host cfg;
    inherit (cfg) system userList moduleList stateVersion;
  });

  # mkHost = host: cfg: if lib.hasSuffix "linux" cfg.system
  #   then import ./mkNixos.nix (xargs // { inherit host cfg; })
  # else import ./mkDarwin.nix (xargs // { inherit host cfg; });

  # mkHome = host: cfg: let user = builtins.attrsName (
  #   lib.genAttrs cfg.userList (user: "${user}"));
  # in lib.nameValuePair ("${user}@${host}") (
  #   import ./mkHome.nix (args // { inherit host cfg; })
  # );

  # mkHome = _: cfg: import ./mkHome.nix (args // {
  #   inherit cfg;
  # });

  utils = import ./utils.nix;
}
