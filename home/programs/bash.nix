{ pkgs, ... }:

{
  programs.bash = {
    enable = true;

    shellAliases = {
      ".." = "cd ..";
      "..." = "cd ../../";
      "...." = "cd ../../../";
      "....." = "cd ../../../../";
      "cat" = "cat -n";
      "fcheck" = "nix flake check";
      "fshow" = "nix flake show";
      "frebuild" = "sudo nixos-rebuild switch --flake";
      "dotfiles" = "cd ~/.dotfiles";
    };

    # Customize bash prompt easily with the link below
    # https://bash-prompt-generator.org/

    initExtra = ''
      function bashPrompt {
        git_branch=$(git branch --show-current 2>/dev/null)
        if [ -z "$git_branch" ]; then
          PS1='\[\e[38;5;151m\]|\[\e[0m\] \[\e[38;5;111m\]\[\e[0m\] \[\e[38;5;217m\]\u\[\e[0m\] \[\e[38;5;151m\]in\[\e[0m\] \[\e[38;5;111m\]\[\e[0m\] \[\e[38;5;217m\]\w\n\[\e[38;5;151m\]\$\[\e[0m\] '
        else
          PS1='\[\e[38;5;111m\]\[\e[0m\] \[\e[38;5;217m\]$(git_branch)\[\e[0m\] \[\e[38;5;151m\]|\[\e[0m\] \[\e[38;5;111m\]\[\e[0m\] \[\e[38;5;217m\]\u\[\e[0m\] \[\e[38;5;151m\]in\[\e[0m\] \[\e[38;5;111m\]\[\e[0m\] \[\e[38;5;217m\]\w\n\[\e[38;5;151m\]\$\[\e[0m\] '
        fi
      }
    '';
  };
}
