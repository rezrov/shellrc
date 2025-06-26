#!/bin/bash

# Environment variables used by both interactive and non-interactive shells.
# Make your modifications after "MODIFICATIONS BELOW THIS LINE"

# Don't change these lines
source "$HOME/.shellrc/bash_functions.bash"
set_os_type
export KITTY_CONFIG_DIRECTORY="$HOME/.shellrc/kitty/$OS_TYPE"

# MODIFICATIONS BELOW THIS LINE

if [ "$OS_TYPE" = "macos" ]; then
  export MOUNT_DIR=/Volumes
else
  export MOUNT_DIR=/mnt
fi
