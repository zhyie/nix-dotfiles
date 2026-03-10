{ ... }:
{
  users.users.zhyie = {
    extraGroups = [
      "wheel"
      "audio"
      "video"
    ];
  };

  #home-manager.users.zhyie.imports = [ home.default ./home.nix ];
}
