{ nixos, hostConfig, ... }:
{
  imports = [ nixos.security.fail2ban ];

  services.openssh = {
    enable = true;
    ports = [ 7238 ];
    settings = {
      PasswordAuthentication = false;
      KbdInteractiveAuthentication = false;
      PermitRootLogin = "no";
      AllowUsers = hostConfig.users;
    };
  };

  programs.ssh.startAgent = true;
  /**
    FIXME: Niri modules enabled `services.gnome.gnome-keyring`
    which enabled `services.gnome.gcr-ssh-agent.enable'
    and causes the failed assertion:

      `programs.ssh.startAgent' and
      `services.gnome.gcr-ssh-agent.enable'
      cannot both be enabled at the sametime.

    `programs.niri.enable` option from Niri modules is declared
    in `flake/modules/nixos/profiles/gui/gui.nix`.
  */
  services.gnome.gcr-ssh-agent.enable = false;
}
