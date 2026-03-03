{ pkgs, ... }:

{
  programs.bash = {
    enable = true;

    shellAliases = {
      "cp" = "cp -irv --debug";
      "mv" = "mv -iv --debug";
      "rm" = "rm -Irv";
      "cat" = "cat -n";
      ".." = "cd ..";
      "..." = "cd ../../";
      "...." = "cd ../../../";
      "....." = "cd ../../../../";
      "dots" = "cd ~/.dotfiles";
      "gs" = "git status";
      "ga" = "git add";
      "gc" = "git commit";
      "gp" = "git push github";
    };

    # Customize bash prompt easily with the link below
    # https://bash-prompt-generator.org/
    initExtra = ''
      __prompt_bash() {
        local R='\033[00m'
        local CB='\033[38;5;153m'
        local CG='\033[38;5;157m'
        local CP='\033[38;5;147m'
        local CR='\033[38;5;222m'
        local CY='\033[38;5;210m'
        local default="\[''${CB}\][\A]\[''${R}\] \[''${CG}\] \u\[''${R}\] \[''${CB}\] \w\[''${R}\]"
        local sign="\n\[''${CG}\]\$\[''${R}\] "
        local branch=$(git branch --show-current 2> /dev/null)
        local git=""

        if [ -n "$branch" ]; then
          local color=$CP
          if ! git diff-files --quiet 2> /dev/null; then
            color=$CR
          elif ! git diff-index --cached --quiet HEAD 2> /dev/null; then
            color=$CY
          fi
          git=" \[''${color}\] $branch\[''${R}\]"
        fi

        PS1="''${default}''${git}''${sign}"
      }
      export PROMPT_COMMAND="__prompt_bash"
    '';
  };
}
