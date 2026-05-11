#!/bin/bash

# $PATH modifications for interactive and non-interactive shells
# Make modifications under "MODIFICATIONS BELOW THIS LINE"

# Don't change these lines
source "$HOME/.shellrc/bash_functions.bash"
set_os_type

# MODIFICATIONS BELOW THIS LINE

if [ "$OS_TYPE" = "macos" ]; then
  if [ -x "/opt/homebrew/bin/brew" ]; then
    # Prepend gnubin/uubin dirs for any installed keg-only GNU or uutils
    # formulae (gnu-sed, gnu-tar, grep, findutils, coreutils, uutils-*, etc.).
    # Discovered dynamically so installing or removing a formula takes effect
    # on the next shell start without editing this file.
    for d in /opt/homebrew/opt/*/libexec/gnubin /opt/homebrew/opt/*/libexec/uubin; do
      [ -d "$d" ] && prepend_to_path "$d"
    done
    prepend_to_path "/opt/homebrew/sbin"
    prepend_to_path "/opt/homebrew/bin"
    [ -z "${MANPATH-}" ] || export MANPATH=":${MANPATH#:}";
    export INFOPATH="/opt/homebrew/share/info:${INFOPATH:-}";
  fi
fi