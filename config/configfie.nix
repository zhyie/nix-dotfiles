{ config, lib, ... }:

let
  outlink = config.lib.file.mkOutOfStoreSymlink;
in

{
  # homeFile = cfg: path: { isRecursive ? true }: {
  #   "${cfg}" = {
  #     source = path;
  #     recursive = isRecursive;
  #   };
  # };

  configFile = cfg: let
    outlink = config.lib.file.mkOutOfStoreSymlink;
  in { "${cfg}" = {
      source = outlink ./${cfg};
      recursive = true;
    };
  };
}
