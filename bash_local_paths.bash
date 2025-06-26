#!/bin/bash

# Make $PATH modifications that are relevant to interactive shells here, below
# the line "MODIFICATIONS BELOW THIS LINE".

# Don't change these lines
source "$HOME/.shellrc/bash_functions.bash"
source "$HOME/.shellrc/bash_system_paths.bash"

# MODIFICATIONS BELOW THIS LINE

# Uncomment the following to use local npm and pnpm directories
#
# NPM_CONFIG_PREFIX="$HOME/.npmlocal"
# PNPM_HOME="$HOME/.pnpmlocal"
#
# if [ -d "$NPM_CONFIG_PREFIX" ]; then
#   export NPM_CONFIG_PREFIX
#   prepend_to_path "$NPM_CONFIG_PREFIX/bin"
# fi
#
# if [ -d "$PNPM_HOME" ]; then
#   export PNPM_HOME
#   prepend_to_path "$PNPM_HOME/bin"
# fi
