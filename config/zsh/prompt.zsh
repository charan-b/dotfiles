autoload -U colors && colors

git_info() {
  local branch="$(git rev-parse --abbrev-ref HEAD 2> /dev/null)"
  [ -n "${branch}" ] && echo "%{$fg[yellow]%}%{$fg[magenta]%} $branch%{$reset_color%}"
}

NEWLINE=$'\n'
PROMPT=' %{$fg[cyan]%}%~%{$reset_color%} $(git_info)${NEWLINE} %(?:%{$fg_bold[green]%}~~> :%{$fg_bold[red]%}~~> )'

# Transient Prompt
zle-line-init() {
  emulate -L zsh

  [[ $CONTEXT == start ]] || return 0

  while true; do
    zle .recursive-edit
    local -i ret=$?
    [[ $ret == 0 && $KEYS == $'\4' ]] || break
    [[ -o ignore_eof ]] || exit 0
  done

  local saved_prompt=$PROMPT
  local saved_rprompt=$RPROMPT
  PROMPT='${NEWLINE}%{$fg_bold[black]%} %~ %{$reset_color%}'
  RPROMPT=''
  zle .reset-prompt
  PROMPT=$saved_prompt
  RPROMPT=$saved_rprompt

  if (( ret )); then
    zle .send-break
  else
    zle .accept-line
  fi
  return ret
}

zle -N zle-line-init
