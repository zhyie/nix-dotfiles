{ config, lib, ... }:

let
  inherit (lib) mkOption types;
in
{
  options.variables = {
    enable = lib.mkEnableOption "Let modules use defined variables.";

    #: Flake variables
    flake = {
      name = mkOption {
        type = types.str;
        default = "flake";
        description = "Name of the path of nixos flake directory.";
      };
      path = mkOption {
        type = types.path;
        default = "${config.home.homeDirectory}/${config.variables.flake.name}";
        description = "Path of the nixos flake directory.";
      };
    };

    #: Global user variables
    user = {
      name = mkOption {
        type = types.str;
        description = "User name.";
      };
      email = mkOption {
        type = types.str;
        description = "User email.";
      };
    };

    #: Variables that git will use
    git = {
      user = mkOption {
        type = types.str;
        default = config.variables.user.name;
        description = "Git user name.";
      };
      email = mkOption {
        type = types.str;
        default = config.variables.user.email;
        description = "Git user email.";
      };
    };
  };

  #: CONFIG ------------------------------
  # config = {
  #   variables = {
  #     git = {
  #       user = lib.mkDefault config.variables.user.name;
  #       email = lib.mkDefault config.variables.user.email;
  #     };
  #   };
  # };
}
