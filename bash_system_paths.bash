#!/bin/bash

# $PATH modifications for interactive and non-interactive shells
# Make modifications under "MODIFICATIONS BELOW THIS LINE"

# Don't change these lines
source "$HOME/.shellrc/bash_functions.bash"
set_os_type

# MODIFICATIONS BELOW THIS LINE

if [ "$OS_TYPE" = "macos" ]; then
  prepend_to_path "/opt/homebrew/opt/gnu-tar/libexec/gnubin"
  prepend_to_path "/opt/homebrew/opt/gnu-sed/libexec/gnubin"
  prepend_to_path "/opt/homebrew/opt/grep/libexec/gnubin"
  prepend_to_path "/opt/homebrew/opt/findutils/libexec/gnubin"
  prepend_to_path "/opt/homebrew/sbin"
  prepend_to_path "/opt/homebrew/bin"
  [ -z "${MANPATH-}" ] || export MANPATH=":${MANPATH#:}";
  export INFOPATH="/opt/homebrew/share/info:${INFOPATH:-}";
fi
