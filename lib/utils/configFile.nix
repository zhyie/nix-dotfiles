{ config, dots, name, isRecursive ? true, ... }:

let
  outLink = config.lib.file.mkOutOfStoreSymlink;
in

{
  "${name}" = {
    source = outLink dots.${name};
    recursive = isRecursive;
  };
}
