#!/usr/bin/fish

# Do not modify this file. Put custom fish function in ~/.shellrc/fish_functions_custom.fish

function prepend_to_path
    set -l dir "$argv[1]"
    if test -d "$dir" -a ":$PATH:" != "*:$dir:*"
        set -gx PATH "$dir" $PATH
    end
end

function log_sourcing
    set -l message "$argv[1]"
    if test -n "$BASH_LOG" -a -w "$BASH_LOG"
        echo "($fish_pid) $message" >> "$BASH_LOG"
    end
end

source ~/.shellrc/fish_functions_custom.fish
