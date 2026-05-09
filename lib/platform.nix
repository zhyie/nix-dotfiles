{
  lib,
  inputs,
  hosts,
  ...
}:
{
  isLinux = p: f: if (lib.hasSuffix "linux" p) then f else null;
  isDarwin = p: f: if (lib.hasSuffix "darwin" p) then f else null;

  systemList = lib.unique (lib.attrValues (lib.mapAttrs (_: h: h.system) hosts));
  eachSystem = f: lib.genAttrs lib.systemList (system: f inputs.nixpkgs.legacyPackages.${system});
}
