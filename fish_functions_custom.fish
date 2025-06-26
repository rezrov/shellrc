#!/usr/bin/fish

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
    if [ "$argv" = "" ]
        echo "Usage: r COMMAND" 1>&2
    else
        set screen_which_test `which $argv[1] 2>&1`
        if [ $status -ne 0 ]
            echo $screen_which_test 1>&2
        else
            set screen_command_name `echo $argv[0] | sed -r 's/^.+\///g'`
            screen -d -m -S "$screen_command_name" $argv[2..-1]
        end
    end
end

function gen_rand
    set pw_len $argv[1]
    string match -r '^[0-9]{1,7}$' or set pw_len 20
    set PW (cat /dev/urandom | tr -dc '2-9a-hjkmnp-zA-HJKMNP-Z_#!=.+' | head -c $pw_len)
end
