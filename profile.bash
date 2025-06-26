#!/bin/bash

# Do not modify this file. Put your modifications in one of the
# files sourced by this file instead.

# symlink this to ~/.profile (not .bash_profile) for best compatibility

source "$HOME/.shellrc/bash_functions.bash"

if is_interactive_shell; then
  iecho "Login shell $BASH_VERSION"
  source "$HOME/.shellrc/bashrc.bash"
else
  source "$HOME/.shellrc/bash_system_envs.bash"
  source "$HOME/.shellrc/bash_system_paths.bash"
  export PATH
fi
