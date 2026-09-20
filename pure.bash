# Pure-like prompt for Bash
# Inspired by https://github.com/sindresorhus/pure

[[ -n ${PURE_BASH_LOADED:-} ]] && return
PURE_BASH_LOADED=1


# =============================================================================
# ANSI colors
# =============================================================================

PURE_ANSI_RESET='\[\e[0m\]'
PURE_ANSI_BRIGHT_BLACK='\[\e[90m\]'
PURE_ANSI_BLUE='\[\e[34m\]'
PURE_ANSI_MAGENTA='\[\e[35m\]'
PURE_ANSI_RED='\[\e[31m\]'

PURE_PROMPT_SYMBOL='❯'


# =============================================================================
# SSH
# =============================================================================

__pure_is_ssh() {
    [[ -n ${SSH_CONNECTION:-} ||
       -n ${SSH_CLIENT:-} ||
       -n ${SSH_TTY:-} ||
       -n ${PURE_SSH_CONNECTION:-} ]] && return 0

    local who_out
    who_out=$(who -m 2>/dev/null) || return 1

    if [[ $who_out =~ \([^()]+\)[[:space:]]*$ ]]; then
        export PURE_SSH_CONNECTION=1
        return 0
    fi

    return 1
}


__pure_ssh_info() {
    __pure_is_ssh || return

    local host=${HOSTNAME:-}
    [[ -n $host ]] || host=$(hostname 2>/dev/null)

    host=${host%%.*}

    printf '%s(%s)%s ' \
        "$PURE_ANSI_BRIGHT_BLACK" \
        "$host" \
        "$PURE_ANSI_RESET"
}


# =============================================================================
# Git
# =============================================================================

__pure_git_info() {
    git rev-parse --is-inside-work-tree &>/dev/null || return

    local branch
    branch=$(git symbolic-ref --quiet --short HEAD 2>/dev/null) ||
        branch=$(git rev-parse --short HEAD 2>/dev/null) ||
        return

    local dirty=''

    if [[ -n $(GIT_OPTIONAL_LOCKS=0 \
        git status \
        --porcelain \
        --ignore-submodules=dirty \
        2>/dev/null) ]]; then
        dirty='*'
    fi

    local arrows=''
    local counts behind ahead

    if counts=$(
        git rev-list \
            --left-right \
            --count \
            '@{upstream}...HEAD' \
            2>/dev/null
    ); then
        read -r behind ahead <<< "$counts"

        (( behind > 0 )) && arrows+='⇣'
        (( ahead > 0 )) && arrows+='⇡'
    fi

    printf ' %s%s%s%s%s' \
        "$PURE_ANSI_BRIGHT_BLACK" \
        "$branch" \
        "$dirty" \
        "${arrows:+ $arrows}" \
        "$PURE_ANSI_RESET"
}


# =============================================================================
# Prompt
# =============================================================================

__pure_prompt_command() {
    local exit_code=$?

    local prompt_color="$PURE_ANSI_MAGENTA"

    if (( exit_code != 0 )); then
        prompt_color="$PURE_ANSI_RED"
    fi

    local ssh_info
    local git_info

    ssh_info=$(__pure_ssh_info)
    git_info=$(__pure_git_info)

    PS1="\n${ssh_info}${PURE_ANSI_BLUE}\w${PURE_ANSI_RESET}${git_info}
${prompt_color}${PURE_PROMPT_SYMBOL}${PURE_ANSI_RESET} "
}


PROMPT_COMMAND=__pure_prompt_command
