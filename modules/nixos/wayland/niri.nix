{ pkgs, ... }:
{
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

  environment.systemPackages = [ pkgs.xwayland-satellite ];
}
