#!/bin/bash

# Do not modify this file, instead, put your custom bash functions in ~/.shellrc/bash_functions_custom.bash
# This file uses the existence of the set_os_type function, which is used in many associated scripts,
# to determine if this file has already been sourced. The functions in this file are used by other
# scripts in this configuration, so do not remove them.

if ! declare -f set_os_type &>/dev/null; then

  function set_os_type {

    if [ -z "$OS_TYPE" ]; then

      local os
      os=$(uname -a 2>/dev/null)

      case $os in
        *icrosoft*)
          OS_TYPE="wsl"
          ;;
        *Darwin*)
          OS_TYPE="macos"
          ;;
        *)
          OS_TYPE="linux"
          ;;
      esac

      export OS_TYPE

    fi

  }

  function is_interactive_shell {
    case $- in
      *i*)
        return 0
        ;;
    esac
    return 1
  }

  function is_remote_shell {
    if ps ax | grep ^$PPID'.*sshd' &>/dev/null; then
      return 0
    fi
    return 1
  }

  # Echo if shell is interactive
  function iecho {
    is_interactive_shell && echo "$1"
  }

  prepend_to_path() {
    local dir="$1"
    case ":$PATH:" in
      *":$dir:"*)
        # Directory is already in the PATH
        ;;
      *)
        # Directory is not in the PATH, prepend it
        PATH="$dir:${PATH:+"$PATH"}"
        ;;
    esac
  }

  # Function to help debugging these setup scripts. Set the $BASH_LOG environment variable to
  # an existing writeable file to enable logging.
  log_sourcing() {
    local message="$1"
    if [[ -n "${BASH_LOG}" && -w "${BASH_LOG}" ]]; then
      echo "($$) $message" >>"$BASH_LOG"
    fi
  }

  if [[ -r "$HOME/.shellrc/bash_functions_custom.bash" ]]; then
    source "$HOME/.shellrc/bash_functions_custom.bash"
  fi

fi