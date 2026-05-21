{ inputs, ... }:
{
  imports = [
    inputs.self.modules.common.modules
    inputs.self.modules.common.variables
  ];

  # options.modules = {
  #   wayland = {
  #     enable = { };
  #   };
  #   xserver = {
  #     enable = { };
  #   };
  # };
}
