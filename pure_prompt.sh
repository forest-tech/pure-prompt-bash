#!/usr/bin/env bash

# Pure-style prompt for Bash.
# Usage: source /path/to/pure_prompt.sh

_pure_prompt_command() {
  local exit_code=$?
  local reset='\[\e[0m\]'
  local cyan='\[\e[36m\]'
  local magenta='\[\e[35m\]'
  local red='\[\e[31m\]'
  local green='\[\e[32m\]'

  local host_part=""
  if [[ -n "${SSH_CONNECTION-}" || -n "${SSH_CLIENT-}" || -n "${SSH_TTY-}" ]]; then
    host_part=" ${magenta}@${HOSTNAME%%.*}${reset}"
  fi

  local status_part=""
  if [[ $exit_code -ne 0 ]]; then
    status_part="${red}${exit_code}${reset} "
  fi

  local symbol="${green}❯${reset}"
  if [[ $EUID -eq 0 ]]; then
    symbol="${red}#${reset}"
  fi

  PS1="${status_part}${cyan}\w${reset}${host_part}"$'\n'"${symbol} "
}

PROMPT_COMMAND=_pure_prompt_command
