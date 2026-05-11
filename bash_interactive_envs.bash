#!/bin/bash

# Put environment variables and shell configuration commands relevant for
# interactive shells here, below "MODIFICATIONS BELOW THIS LINE".

# Don't change these lines
source "$HOME/.shellrc/bash_system_envs.bash"
source "$HOME/.shellrc/bash_functions.bash"
set_os_type

# MODIFICATIONS BELOW THIS LINE

shopt -s histappend
shopt -s checkwinsize
export VIMINIT=':set nocompatible'
export HISTSIZE=50000
export HISTFILESIZE=5000000
export HISTCONTROL="ignoreboth"
export TZ="America/Detroit"

for _ed in emacs vim nano vi; do
  if command -v "$_ed" >/dev/null 2>&1; then
    export EDITOR="$_ed"
    break
  fi
done
unset _ed

umask 0022

# You can set OS-specific environment variables
if [ "$OS_TYPE" = "macos" ]; then
  export HOMEBREW_PREFIX="/opt/homebrew";
  export HOMEBREW_CELLAR="/opt/homebrew/Cellar";
  export HOMEBREW_REPOSITORY="/opt/homebrew";
fi
