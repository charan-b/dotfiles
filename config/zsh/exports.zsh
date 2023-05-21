#!/bin/sh

export XDG_CACHE_HOME="$HOME"/.cache
export XDG_DATA_HOME="$HOME"/.local/share
export XDG_CONFIG_HOME="$HOME"/.config
export GOPATH="$HOME/.local/share/go"
export GOMODCACHE="$XDG_CACHE_HOME"/go/mod
# PATH
export PATH="$HOME/.local/bin":$PATH
export PATH="${XDG_DATA_HOME:-$HOME/.local/share}/cargo/bin":$PATH
export PATH="/home/charan/.local/share/anaconda3/bin:$PATH"
export PATH="$GOPATH/bin":$PATH
export PATH=$PATH:~/.config/spicetify
export XCURSOR_PATH=${XCURSOR_PATH}:~/.local/share/icons

# Environment variables set everywhere
export EDITOR="nvim"
export VISUAL="nvim"
# export MANPAGER="sh -c 'col -bx|bat -l man -p'"
export TERMINAL="kitty"
export KODI_DATA="$HOME"/.local/share/kodi
export BROWSER="firefox"
export QT_QPA_PLATFORMTHEME=qt5ct # For QT Themes
export QT_QPA_PLATFORM=wayland
export QT_WAYLAND_DISABLE_WINDOWDECORATION=1
export QT_AUTO_SCREEN_SCALE_FACTOR=1
export MOZ_ENABLE_WAYLAND=1
export CARGO_HOME="${XDG_DATA_HOME:-$HOME/.local/share}/cargo"
export RUSTUP_HOME="${XDG_DATA_HOME:-$HOME/.local/share}/rustup"
export GNUPGHOME="${XDG_DATA_HOME:-$HOME/.local/share}/gnupg"
export GNUPGHOME="$HOME"/.local/share/gnupg
export XDG_CURRENT_DESKTOP="Wayland"
export LS_COLORS="${LS_COLORS}ow=0;95"    # ls color
export NPM_CONFIG_USERCONFIG=$XDG_CONFIG_HOME/npm/npmrc

## FZF stuff
export FZF_DEFAULT_COMMAND="${FZF_DEFAULT_COMMAND:-"fd --base-directory ~ -L --type f --exclude='*.srt'"}"
export FZF_DEFAULT_OPTS="${FZF_DEFAULT_OPTS:-"--layout=reverse --inline-info"}"

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

export FZF_ALT_C_COMMAND='fd . -aL --type d --base-directory $HOME'
export FZF_ALT_C_OPTS="
--with-nth=4.. -d /
--header='Jump to location'
--preview 'tree -C {}|head -200'
--scheme=path
--bind 'ctrl-/:change-preview-window(down|hidden|)'
--height 90%"
