{ pkgs, ... }:
{
  home.packages = [ pkgs.unstable.nushell ];
  programs = {
    bash.initExtra = ''
      if ! [ "$TERM" = "dumb" ] && [ -z "$BASH_EXECUTION_STRING" ]; then
        exec nu
      fi
    '';
  };
}
