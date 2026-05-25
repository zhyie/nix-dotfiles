{
  fn,
  lib,
  hosts,
  ...
}:
{
  mapHost = lib.mapAttrs (hostName: hostConfig: { inherit hostName hostConfig; }) hosts;

  getHostName = host: fn.mapHost.${host}.hostName;
  getHostConfig = host: fn.mapHost.${host}.hostConfig;

  # filterHostConfigs = host: lib.attrValues (lib.mapAttrs (_: h: filterAttrs ()) fn.mapHost);
}
