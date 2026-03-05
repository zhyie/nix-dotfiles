{ config, lib, isRecursive ? false, ... }:

cfg: path: let
  outlink = config.lib.file.mkOutOfStoreSymlink;
  homepath = config.home.homeDirectory;
in

{
  home.file."${cfg}" = {
    source = path;
    recursive = isRecursive;
  };
}
