#!/usr/bin/fish

# Symlink this file from ~/.config/fish/config.fish
# Make your modifications in the section labeled "MODIFICATIONS HERE"

function move_to_front
    set -l dir "$argv[1]"
    set -e PATH[(contains -i "$dir" $PATH)]
    set -p PATH "$dir"
end

set -l path_dirs $PATH

for dir in () $path_dirs
    if string match -q "$HOME*" "$dir"
        move_to_front "$dir"
    end
end

if status --is-interactive

    source ~/.shellrc/fish_functions.fish
    eval (~/.shellrc/bin/fish_aliases.bash)

    ###########################
    # MODIFICATIONS HERE

    if [ -d ~/.local/share/omf/pkg/colorman ]
     source ~/.local/share/omf/pkg/colorman/init.fish
    end

    if [ -d ~/.local/share/omf/pkg/fish_logo ]
        fish_logo
    end

    echo

    # uncomment for rust developers
    # if [ -f ~/.cargo/env.fish ]
    #     source ~/.cargo/env.fish
    # end

    ###########################
    # END MODIFICATIONS

end