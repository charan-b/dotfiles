#!/bin/sh

export LS_COLORS="${LS_COLORS}ow=0;95"    # ls color

## FZF stuff
export FZF_DEFAULT_COMMAND="fd"
export FZF_DEFAULT_OPTS="--layout=reverse --inline-info --color=gutter:-1"

export FZF_CTRL_T_COMMAND='fd . -aL --base-directory $HOME'
# --preview '(highlight -O ansi -l {} || bat -n --color=always {} || tree -C {}) 2> /dev/null | head -200'
export FZF_CTRL_T_OPTS="
--with-nth=4.. -d /
--preview '([[ -f {} ]] && (file -bL --mime-type {}|grep -iq "text") && (bat --style=numbers --color=always {})) \
    || ([[ -d {} ]] && (tree -C {})) \
    || dirname "{}" |xargs -I "{}" tree "{}" 2> /dev/null | head -200'
--bind 'ctrl-/:change-preview-window(down|hidden|)'
--scheme=path
--height 90%"
export FZF_CTRL_R_OPTS="
--preview 'echo {}'
--preview-window up:3:hidden:wrap
--bind '?:toggle-preview'
--bind 'ctrl-y:execute-silent(echo -n {2..} | wl-copy)+abort'
--color header:italic
--height 50%
--header 'Press CTRL-Y to copy command into clipboard'"

export FZF_ALT_C_COMMAND='fd . -aLH --type d --base-directory $HOME \
--exclude={".var/",".cache/",".npm/",".git/","flatpak/","Trash/",".Trash-1000/","trash/"}'
export FZF_ALT_C_OPTS="
--with-nth=4.. -d /
--header='Jump to location'
--preview 'tree -C {}|head -200'
--scheme=path
--bind 'ctrl-/:change-preview-window(down|hidden|)'
--height 90%"
