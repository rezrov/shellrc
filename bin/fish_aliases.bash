#!/bin/bash

# Reads aliases from bash shell and prints them in a format
# that can be understood by fish. Note that the aliases
# themselves must be understandable by fish shell. If you
# have one that can't be written for both, consider adding
# the shell-specific versions as functions in bash_functions_custom.bash
# and fish_functions_custom.fish instead of using an alias.

source ~/.shellrc/bash_aliases.bash

IFS=$'\n'
pat='^alias ([^=]+)=.(.+).$'
for al in $(alias)
do
    if [[ $al =~ $pat ]]; then
        echo "alias ${BASH_REMATCH[1]} '${BASH_REMATCH[2]}'; "
    fi
done
