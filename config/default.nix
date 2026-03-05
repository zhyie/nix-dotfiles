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

  configFile = cfg: {
    "${cfg}" = {
      source = outlink ./${cfg};
      recursive = true;
    };
  };
}
