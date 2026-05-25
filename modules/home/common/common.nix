{ osConfig, inputs, ... }:
{
  imports = [
    inputs.self.modules.common.modules
    inputs.self.modules.common.variables
  ];

  modules.xserver.enable = osConfig.modules.xserver.enable;
  modules.wayland.enable = osConfig.modules.wayland.enable;
}
