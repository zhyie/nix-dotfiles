{
  lib',
  lib,
  hosts,
  ...
}:
{
  mapHost = lib.mapAttrs (hostName: hostConfig: { inherit hostName hostConfig; }) hosts;

  getHostName = host: lib'.mapHost.${host}.hostName;
  getHostConfig = host: lib'.mapHost.${host}.hostConfig;

  # filterHostConfigs = host: lib.attrValues (lib.mapAttrs (_: h: filterAttrs ()) lib'.mapHost);
}
