#!/usr/bin/env bash

# Reads aliases from bash shell and prints them in a format
# that can be understood by fish. Note that the aliases
# themselves must be understandable by fish shell. If you
# have one that can't be written for both, consider adding
# the shell-specific versions as functions in bash_functions_custom.bash
# and fish_functions_custom.fish instead of using an alias.

source ~/.shellrc/bash_aliases.bash

# Bash's `alias` builtin always emits values in single quotes and
# escapes embedded single quotes as '\''. Decode that to a literal
# single quote, then re-encode for fish, where the only escapes
# inside single-quoted strings are \\ and \'.
pat="^alias ([^=]+)='(.*)'$"
while IFS= read -r al; do
    [[ $al =~ $pat ]] || continue
    name="${BASH_REMATCH[1]}"
    body="${BASH_REMATCH[2]}"
    body="${body//\'\\\'\'/\'}"   # bash '\'' -> literal '
    body="${body//\\/\\\\}"        # \ -> \\
    body="${body//\'/\\\'}"        # ' -> \'
    printf "alias %s '%s'; " "$name" "$body"
done < <(alias)
