#!/bin/bash

# You shouldn't make changes to this file directly. Modifications should instead
# be put in one of the files sourced by this file.

# Symlink this file to ~/.bashrc

source "$HOME/.shellrc/bash_functions.bash"

if is_interactive_shell; then
    iecho "Shell is interactive"
    if declare -f sshagent_init > /dev/null; then
        sshagent_init
    fi
fi

source "$HOME/.shellrc/bash_local_envs.bash"
source "$HOME/.shellrc/bash_local_paths.bash"
source "$HOME/.shellrc/bash_aliases.bash"
source "$HOME/.shellrc/bash_set_colors.bash"

export PATH
