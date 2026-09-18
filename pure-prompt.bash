__pure_prompt_bash() {
  local exit_status=$?
  local host_prefix=""
  local branch=""

  if [[ -n "${SSH_CONNECTION:-}" ]]; then
    host_prefix="(${HOSTNAME%%.*}) "
  fi

  branch="$(git symbolic-ref --quiet --short HEAD 2>/dev/null || git rev-parse --short HEAD 2>/dev/null || true)"
  if [[ -n "$branch" ]]; then
    branch=" $branch"
  fi

  PS1="${host_prefix}\w${branch}\n❯ "
  return "$exit_status"
}

if [[ ";${PROMPT_COMMAND:-};" != *";__pure_prompt_bash;"* ]]; then
  PROMPT_COMMAND="${PROMPT_COMMAND:+${PROMPT_COMMAND};}__pure_prompt_bash"
fi
