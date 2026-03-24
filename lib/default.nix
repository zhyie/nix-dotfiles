{ ... }@args:

let
  inherit (args.inputs.nixpkgs) lib;
  # pkgs = import args.inputs.nixpkgs { };
in
{
  # mkHost = host: cfg: import ./mkNixos.nix (args // {
  #   inherit host cfg;
  # });
  mkHost =
    host: cfg:
    # if pkgs.stdenv.hostPlatform.isLinux then
    if lib.hasSuffix "linux" cfg.system then
      import ./mkNixos.nix (
        args
        // {
          # inherit host; inherit (cfg) system userList moduleList;
          inherit host cfg;
        }
      )
    else
      import ./mkDarwin.nix (
        args
        // {
          inherit host cfg;
        }
      );

  # mkHome = host: cfg: let user = lib.attrsName (
  #   lib.genAttrs cfg.userList (user: {}));
  # in lib.nameValuePair ("${user}@${host}") (
  #   import ./mkHome.nix (args // { inherit host cfg; })
  # );
}
