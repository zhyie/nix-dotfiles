{ config, lib, ... }:

let
  inherit (lib)
    mkEnableOption
    mkOption
    types
    mkIf
    mkDefault
    ;
  inherit (types) str path;

  cfg = config.variables;
in
{
  options.variables = {
    enable = mkEnableOption "Let modules use defined variables.";

    #: Flake variables
    flake = {
      name = mkOption {
        type = str;
        default = "flake";
        description = "Name of the path of nixos flake directory.";
      };
      path = mkOption {
        type = path;
        default = null;
        description = "Path of the nixos flake directory.";
      };
    };

    #: Global user variables
    user = {
      name = mkOption {
        type = str;
        description = "User name.";
      };
      email = mkOption {
        type = str;
        description = "User email.";
      };
    };

    #: Variables that git will use
    git = {
      user = mkOption {
        type = str;
        description = "Git user name.";
      };
      email = mkOption {
        type = str;
        description = "Git user email.";
      };
    };
  };

  #: CONFIG ------------------------------
  config = mkIf cfg.enable {
    variables = {
      git = {
        user = mkDefault cfg.user.name;
        email = mkDefault cfg.user.email;
        # user = if cfg.git.user == null then mkDefault cfg.user.name else cfg.git.user;
        # email = if cfg.git.email == null then mkDefault cfg.user.email else cfg.git.email;
      };
    };
  };
}
