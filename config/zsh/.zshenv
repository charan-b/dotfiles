[ -d "~/.local/share/cargo/env" ] && . "/home/charan/.local/share/cargo/env"

export XDG_CACHE_HOME="$HOME"/.cache
export XDG_DATA_HOME="$HOME"/.local/share
export XDG_STATE_HOME="$HOME"/.local/state
export XDG_CONFIG_HOME="$HOME"/.config

export PATH="$HOME"/.local/bin:$PATH
export PATH="$XDG_DATA_HOME"/cargo/bin:$PATH
export PATH="$XDG_DATA_HOME"/anaconda3/bin:$PATH
export PATH="$XDG_DATA_HOME"/go/bin:$PATH
export PATH="$XDG_CONFIG_HOME"/spicetify:$PATH

export GOPATH="$XDG_DATA_HOME/go"
export GOMODCACHE="$XDG_CACHE_HOME"/go/mod
export RUSTUP_HOME="$XDG_DATA_HOME"/rustup
export CARGO_HOME="$XDG_DATA_HOME"/cargo
export NPM_CONFIG_USERCONFIG=$XDG_CONFIG_HOME/npm/npmrc
export WGETRC="$XDG_CONFIG_HOME"/wgetrc
export GNUPGHOME="$XDG_DATA_HOME"/gnupg

# export MANPAGER="sh -c 'col -bx|bat -l man -p'"
export EDITOR="nvim"
export VISUAL="nvim"
export TERMINAL="kitty"
export KODI_DATA="$HOME"/.local/share/kodi
export BROWSER="firefox"
export NVIM_APPNAME=${NVIM_APPNAME:-NvChad}
