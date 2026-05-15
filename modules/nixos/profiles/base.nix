{
  lib,
  nixos,
  hostConfig,
  ...
}:
{
  imports =
    let
      inherit (lib) elem optionals;
      userZhyie = elem "zhyie" hostConfig.userList;
    in
    [
      nixos.common
      nixos.security.sops
    ]
    ++ (optionals userZhyie [ nixos.security.sudo ]);
}
