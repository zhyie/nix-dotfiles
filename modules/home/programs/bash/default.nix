{ ... }:
{
  programs.bash = {
    enable = true;
    historyFileSize = 10000;
    historySize = 1000;
    historyControl = [
      "erasedups"
      "ignoredups"
      "ignorespace"
    ];
    historyIgnore = [
      "ls"
      "cd"
    ];

    shellAliases = {
      "cp" = "cp -irv";
      "mv" = "mv -iv";
      "rm" = "rm -Irv";
      "cat" = "cat -n";
      "la" = "ls --group-directories-first -la";
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

    bashrcExtra = ''
      mvg() {
        if [ -d "$2" ]; then
          mv "$1" "$2" && cd "$2"
        else
          mv "$1" "$2"
        fi
      }
      cpg() {
        if [ -d "$2" ]; then
          cp "$1" "$2" && cd "$2"
        else
          cp "$1" "$2"
        fi
      }
      cpp() {
        set -e
        strace -q -ewrite cp -- "$1" "$2" 2>&1 |
        awk '{
            count += $NF
            if (count % 10 == 0) {
                percent = count / total_size * 100
                printf "%3d%% [", percent
                for (i=0;i<=percent;i++)
                    printf "="
                printf ">"
                for (i=percent;i<100;i++)
                    printf " "
                printf "]\r"
            }
        }
        END { print "" }' total_size="$(stat -c '%s' "$1")" count=0
      }
      mkdirg() {
        mkdir -p "$1"
        cd "$1"
      }
      cd () {
        if [ -n "$1" ]; then
          builtin cd "$@" && ls
        else
          builtin cd ~ && ls
        fi
      }
    '';

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
