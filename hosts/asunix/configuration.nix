{
  config,
  lib,
  inputs,
  hostName,
  hostConfig,
  ...
}:

let
  rev = toString (
    inputs.self.shortRev or inputs.self.dirtyShortRev or inputs.self.lastModified or "unknown"
  );
in
{
  services.xserver.desktopManager.xfce.enable = true;

  isoImage = {
    # EFI booting
    makeEfiBootable = true;
    # USB booting
    makeUsbBootable = true;

    isoName = "${hostName}-${rev}.iso";
  };

  # An installation media cannot tolerate a host config defined file
  # system layout on a fresh machine, before it has been formatted.
  swapDevices = lib.mkImageMediaOverride [ ];
  fileSystems = lib.mkImageMediaOverride config.lib.isoFileSystems;

  time.timeZone = "Asia/Manila";
  #######################################
  #   OFF LIMIT  SYSTEM STATE VERSION   #
  #######################################
  # Do NOT change, unless all the changes it would make to a configuration
  # have been manually inspected and the data is migrated accordingly.
  # For more information, see `man configuration.nix` or
  # https://nixos.org/manual/nixos/stable/options#opt-system.stateVersion.
  system.stateVersion = hostConfig.stateVersion;
  # Help is available in the configuration.nix(5) man page, on
  # https://search.nixos.org/options and in the NixOS manual (`nixos-help`).
}
