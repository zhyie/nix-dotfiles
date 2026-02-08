{ pkgs, ... }:

{

  programs.bash = {
    enable = true;

    shellAliases = {
      ".." = "cd ..";
      "..." = "cd ../../";
      "...." = "cd ../../../";
      "cat" = "cat -n";
    };
    
    # Customize bash prompt easily with the link below
    # https://bash-prompt-generator.org/

    initExtra = ''
      export PS1='\n\[\e[38;5;153m\][\D{%a %b %d %H:%M}]\[\e[0m\] \[\e[38;5;156m\]\u\[\e[0m\] \[\e[38;5;224m\]in\[\e[0m\] \[\e[38;5;156m\]\w\[\e[0m\] \[\e[38;5;153m\]$(git branch --show-current 2>/dev/null)\n\[\e[38;5;224m\]\$\[\e[0m\] '
    '';

  };

}
