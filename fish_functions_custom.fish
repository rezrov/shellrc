#!/usr/bin/env fish

# Put your custom fish functions in this file. They will not be available in
# bash shell. Custom bash functions are in bash_functions_custom.fish

# Remove trailing whitespace from all lines in text file (GNU sed)
# https://stackoverflow.com/questions/4438306/how-to-remove-trailing-whitespaces-with-sed
function rmts
    sed -Ei -e's/[[:space:]]*$//' $argv
end

# Remove trailing \r (DOS-style CRLF line endings) from all lines in text file
function d2u
    sed -i 's/\r$//' $argv
end

# r COMMAND: Backgrounds a command in a screen session. The command's text
# output is collected by screen and available via screen -r if you need it.
function r
    if test (count $argv) -eq 0
        echo "Usage: r COMMAND" 1>&2
        return 1
    end
    if not command -v $argv[1] >/dev/null 2>&1
        echo "r: $argv[1]: command not found" 1>&2
        return 1
    end
    set -l screen_command_name (echo $argv[1] | sed -r 's/^.+\///g')
    screen -d -m -S "$screen_command_name" $argv
end

# Generate a random string containing alphanumeric and special characters.
# First argument is length, default 20.
# Special characters included: _#!=.+
function gen_rand
    set -l pw_len $argv[1]
    if not string match -qr '^[0-9]{1,7}$' -- "$pw_len"
        set pw_len 20
    end
    tr -dc '2-9a-hjkmnp-zA-HJKMNP-Z_#!=.+' </dev/urandom | head -c $pw_len
    echo
end
