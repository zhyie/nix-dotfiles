{
  lib,
  inputs,
  hosts,
  ...
}:

rec {
  filterNixos = attrs: lib.filterAttrs (_: c: c.platform == "nixos") attrs;
  filterDarwin = attrs: lib.filterAttrs (_: c: c.platform == "darwin") attrs;
  filterWsl = attrs: lib.filterAttrs (_: c: c.platform == "wsl") attrs;
  filterDroid = attrs: lib.filterAttrs (_: c: c.platform == "droid") attrs;

  isLinux = platform: lib.hasSuffix "linux" platform;
  isDarwin = platform: lib.hasSuffix "darwin" platform;

  systemList = lib.unique (lib.attrValues (lib.mapAttrs (_: host: host.system) hosts));
  eachSystem = f: lib.genAttrs systemList (system: f inputs.nixpkgs.legacyPackages.${system});
}
