#!/bin/sh

# Transient prompt
# See: https://github.com/romkatv/powerlevel10k/issues/888
_vbe-zle-line-init() {
    [[ $CONTEXT == start ]] || return 0

    # Go back to regular edition
    unset _paste_content
    (( $+zle_bracketed_paste )) && print -r -n - $zle_bracketed_paste[1]
    zle .recursive-edit
    local -i ret=$?
    (( $+zle_bracketed_paste )) && print -r -n - $zle_bracketed_paste[2]

    # Received EOT, should exit the shell
    if [[ $ret == 0 && $KEYS == $'\4' ]]; then
        _vbe_prompt_compact=1
        zle .reset-prompt
        exit
    fi

    # Edition of command-line is over, we need to draw a new prompt.
    # Shorten the current one.
    _vbe_prompt_compact=1
    zle .reset-prompt
    unset _vbe_prompt_compact

    if (( ret )); then
        # Ctrl-C
        zle .send-break
    else
        # Enter
        zle .accept-line
    fi
    return ret
}
zle -N zle-line-init _vbe-zle-line-init

_vbe_prompt () {
    local retval=$?

    # When old command, just time + prompt sign
    if (( $_vbe_prompt_compact )); then
        print -n "%b%F{black}%~%b%k%f"
        return
    fi

    print 

    # Directory
    local -a segs
    local remaining=$(($COLUMNS - ${#${(%):-%n@%M}} - 7))
    local pwd=${${(%):-%~}//\%/%%}
    # When splitting, we will loose the leading /, keep it if needed
    local leading=${pwd[1]}
    [[ $leading == / ]] || leading=
    segs=(${(s./.)pwd})
    # We try to shorten middle segments if needed (but not the first, not the last)
    case ${#segs} in
        0) print -n "%b%F{cyan} %B/%b%k%f" ;;
        1) print -n "%b%F{cyan} ${leading}%B${segs[1]}%b%k%f" ;;
        *)
            local i=2
            local current
            while true; do
                current=${leading}${(j./.)${segs[1,-2]}}/%B${segs[-1]}
                (( i < ${#segs} )) || break
                (( ${#current} < remaining )) && break
                segs[i]=${segs[i][1]}
                ((i++))
            done
            print -n "%b%F{cyan} ${(%):-%${remaining//\%/%%}<${PRCH[ellipsis]}<${current//\%/%%}}%b%k%f"
            ;;
    esac

  local branch="$(git rev-parse --abbrev-ref HEAD 2> /dev/null)"
  [ -n "${branch}" ] && print -n "%b%F{yellow} %F{magenta} $branch%b%k%f"

    # New line
    print
    #
     # Error 
     if (( $retval )); then
         print -n "%b%F{red} >%b%k%f"
     else
         print -n "%b%F{green} >%b%k%f"
     fi
}

_vbe_setprompt () {
    setopt prompt_subst
    typeset -g PS1='$(_vbe_prompt) '
    typeset -g PS3="%b%F{green}?%b%k%f "
    typeset -g PS4="%b%F{green}%N%b%F{default}%i%b%k%f "
    typeset -g PROMPT_EOL_MARK="%B${PRCH[eol]}%b"
    unset RPS1
    unset RPS2
    unset RPROMPT
    unset RPROMPT2
}

_vbe_setprompt
