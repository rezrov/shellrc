#!/bin/bash

# Put all your shell aliases here, below the line "MODIFICATIONS BELOW THIS LINE".
# Fish shell will pull them in via the fish_aliases script in .shellrc/bin
# The environment variable $OS_TYPE will have the value "macos", "linux", or "wsl".
# Use this to conditionally set aliases specific to each platform.
#
# Some useful aliases: https://gist.github.com/rezrov/d064bec0da8d8902eb3814ebfd16c400

# Don't change these lines
source "$HOME/.shellrc/bash_functions.bash"
set_os_type

# MODIFICATIONS BELOW THIS LINE

if [ "$OS_TYPE" = "macos" ]; then
  # Aliases for macOS only
  unalias ls >/dev/null 2>&1
  alias ls="ls -AFG"
  alias bubu="brew update && brew upgrade && brew cleanup"
  alias kittyterm="kitty +kitten ssh" # https://www.reddit.com/r/KittyTerminal/comments/qflzyq/kitty_inserts_space_when_pressing_backspace_while/
  alias webstorm='open -na "WebStorm.app"'
elif [ "$OS_TYPE" = "linux" ]; then
  # Linux only
  alias ns="ss -naut"
  alias nsp="ss -nautp"
  unalias ls >/dev/null 2>&1
  alias ls="ls -AF --color=always"
  case $osver in
    *gentoo*)
      alias e4="exec startxfce4"
      ;;
  esac
fi

# always grep in color
unalias grep >/dev/null 2>&1

alias grep='grep --color=auto'
alias fgrep='fgrep --color=auto'
alias egrep='egrep --color=auto'

# Remove nasty CR characters
alias tn='tr -d "\r"'

# Total size of all the contents of a directory recursively including subdirectories
alias dh="du -h -d1"

# Fully synchronize the contents of the destination with the source. Use rsn for a dry run first!
alias rs="rsync --progress -r -l -p -t -g -o --del --exclude '- /lost+found'"
alias rsn="rs -n"

# Make the contents of the current directory available via web browser.
alias pserve="python3 -m http.server 9090"

# Command history without line numbers, and a shortcut to grep the results
alias hn='history |sed -r -e '\''s/^(\s*[0-9]+\s+)//g'\'''
alias hg="hn|grep"

# switch to fish shell
alias ef="exec fish -i"

# Miscellaneous
alias sl='screen -list'
alias sr='screen -r'
alias wtail='watch -n 5 tail -n 20'
alias si="sudo -i"

