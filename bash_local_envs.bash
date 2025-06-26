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
export FORCE_COLOR="true"
export TZ="America/Detroit"
export EDITOR="emacs"
export PS1='\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[00;38;5;33m\]\w \$\[\033[00m\] '
umask 0022

# You can set OS-specific environment variables
if [ "$OS_TYPE" = "macos" ]; then
  export HOMEBREW_PREFIX="/opt/homebrew";
  export HOMEBREW_CELLAR="/opt/homebrew/Cellar";
  export HOMEBREW_REPOSITORY="/opt/homebrew";
fi
