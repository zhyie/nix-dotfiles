{ config, lib, dots, isRecursive ? true, ... }:

cfg: let
  outlink = config.lib.file.mkOutOfStoreSymLink;
  homepath = config.homeDirectory;

  name = lib.attrNames cfg;
in

{
  ${name} = {
    source = outlink ${cfg};
    recursive = isRecursive;
  };
}
