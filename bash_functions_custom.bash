#!/bin/bash

# Put your custom bash functions in this file. It will be sourced by the
# bash_functions.bash file on shell startup. They will not be available in
# fish shell. Custom fish functions are in fish_functions_custom.fish

# Remove trailing whitespace from all lines in text file (GNU sed)
# https://stackoverflow.com/questions/4438306/how-to-remove-trailing-whitespaces-with-sed
function rmts {
  sed -Ei -e's/[[:space:]]*$//' $1
}

# r COMMAND: Backgrounds a command in a screen session. The command's text
# output is collected by screen and available via screen -r if you need it.
function r {
  if [ "$1" = "" ]; then
    iecho "Usage: r COMMAND" 1>&2
  else
    SCREEN_WHICH_TEST=$(which $1 2>&1)
    if [ $? -ne 0 ]; then
      iecho $SCREEN_WHICH_TEST 1>&2
    else
      SCREEN_COMMAND_NAME=$(echo $1 | sed -r 's/^.+\///g')
      screen -d -m -S "$SCREEN_COMMAND_NAME" $@
    fi
  fi
}

# Generate a random string containing alphanumeric and special characters.
# First argument is length, default 20.
# Special characters included: _#!=.+
function gen_rand {
  local pw_len=$1
  local pw
  [[ $pw_len =~ ^[0-9]{1,7}$ ]] || pw_len=20
  pw=$(tr -dc '2-9a-hjkmnp-zA-HJKMNP-Z_#!=.+' </dev/urandom | head -c "$pw_len")
  iecho "$pw"
}

# A set of functions to manage ssh-agent in a way that is compatible with multiple login sessions.
# https://superuser.com/questions/141044/sharing-the-same-ssh-agent-among-multiple-login-sessions/230872#230872

if [ -x "$(which ssh-add)" ] && [ -x "$(which ssh-agent)" ]; then

  function sshagent_findsockets {
    find /tmp -uid $(id -u) -type s -name agent.\* 2>/dev/null
  }

  function sshagent_testsocket {

    if [ X"$1" != X ]; then
      export SSH_AUTH_SOCK=$1
    fi

    if [ X"$SSH_AUTH_SOCK" = X ]; then
      return 2
    fi

    if [ -S $SSH_AUTH_SOCK ]; then
      ssh-add -l >/dev/null
      if [ $? = 2 ]; then
        iecho "Socket $SSH_AUTH_SOCK is dead!  Deleting!"
        rm -f $SSH_AUTH_SOCK
        return 4
      else
        iecho "Found ssh-agent $SSH_AUTH_SOCK"
        return 0
      fi
    else
      iecho "$SSH_AUTH_SOCK is not a socket!"
      return 3
    fi
  }

  function sshagent_init {
    # ssh agent sockets can be attached to a ssh daemon process or an
    # ssh-agent process.

    AGENTFOUND=0

    # Attempt to find and use the ssh-agent in the current environment
    if sshagent_testsocket; then AGENTFOUND=1; fi

    # If there is no agent in the environment, search /tmp for
    # possible agents to reuse before starting a fresh ssh-agent
    # process.
    if [ $AGENTFOUND = 0 ]; then
      for agentsocket in $(sshagent_findsockets); do
        if [ $AGENTFOUND != 0 ]; then break; fi
        if sshagent_testsocket $agentsocket; then AGENTFOUND=1; fi
      done
    fi

    # If at this point we still haven't located an agent, it's time to
    # start a new one
    if [ $AGENTFOUND = 0 ]; then
      eval $(ssh-agent)
    fi

    # Clean up
    unset AGENTFOUND
    unset agentsocket

    # Finally, show what keys are currently in the agent
    ssh-add -l

  }

fi