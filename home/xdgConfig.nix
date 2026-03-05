{ config, lib, isRecursive ? true, ... }:

cfg: path: let
  outlink = config.lib.file.mkOutOfStoreSymlink;
  homepath = config.home.homeDirectory;
in

{
  xdg.configFile."${cfg}" = {
    source = outlink path;
    recursive = isRecursive;
  };
}
