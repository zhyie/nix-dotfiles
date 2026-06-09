{ inputs, ... }:
{
  xdg.configFile = {
    "nvim/init.lua".source = "${inputs.dotfiles}/nvim/lua/config/options.lua";
  };
}
