{ inputs, pkgs, ... }:
{
  imports = [ inputs.noctalia.nixosModules.default ];

  /**
    FIXME: Niri modules enabled `services.gnome.gnome-keyring`
    which enabled `services.gnome.gcr-ssh-agent.enable'
    and causes the failed assertion:

      `programs.ssh.startAgent' and
      `services.gnome.gcr-ssh-agent.enable'
      cannot both be enabled at the sametime.

    `services.gnome.gcr-ssh-agent.enable` is set to false
    in `flake/modules/nixos/services/ssh` to temporatily
    fix the failed assertion.
  */
  programs.niri = {
    enable = true;
    package = pkgs.unstable.niri;
  };

  #: noctalia-shell
  # services.noctalia-shell = {
  #   enable = true;
  #   # package = pkgs.noctalia-shell;
  # };

  #: xwayland support
  environment.systemPackages = [ pkgs.xwayland-satellite ];

  /**
    TODO: Configure manually niri modules.

    environment.systemPackages = [
      pkgs.niri
      pkgs.xwayland-satellite
    ];

    services = {
      displayManager.sessionPackages = [ pkgs.niri ];

      graphical-desktop.enable = true;
      xserver.desktopManager.runXdgAutostartIfNone = lib.mkDefault true;
    };

    # Recommended by upstream
    # https://github.com/YaLTeR/niri/wiki/Important-Software#portals
    # services.gnome.gnome-keyring.enable = lib.mkDefault true;

    systemd = {
      packages = [ pkgs.niri ];

      user.services.niri = {
        restartIfChanged = false;
        enableDefaultPath = false;
      };
    };

    xdg.potal = {
      enable = lib.mkDefault true;

      config.niri = {
        default = [ "gtk" ];
      };

      # Recommended by upstream, required for screencast support
      # https://github.com/YaLTeR/niri/wiki/Important-Software#portals
      # extraPortals = [ pkgs.xdg-desktop-portal-gnome ];
      extraPortals = [ pkgs.xdg-desktop-portal-gtk ];
    };

    security.polkit.enable = true;
    programs.dconf.enable = lib.mkDefault true;
  */
}
