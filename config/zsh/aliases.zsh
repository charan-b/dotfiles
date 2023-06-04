#!/bin/sh

alias zshup="find "$ZDOTDIR/plugins" -type d -exec test -e '{}/.git' ';' -print0 | xargs -I {} -0 git -C {} pull -q"

# Colorize grep output (good for log files)
alias grep='grep --color=auto'
alias egrep='grep -E --color=auto'
alias fgrep='fgrep --color=auto'

# confirm before overwriting something
alias cp="cp -irv"
alias mv='mv -iv'
alias rm='rm -irv'
alias ln='ln -i'
alias mkdir="mkdir -pv"

alias new="/usr/bin/ls -lth | head -15"    # a quick glance at the newest files.
alias big="command du -a -BM | sort -n -r | head -n 10" # Find 10 largest files in pwd.

# easier to read disk
alias df='df -h'     # human-readable sizes
alias free='free -m' # show sizes in MB

alias es="exec $SHELL"

# get top process eating memory
alias psmem='ps auxf | sort -nr -k 4 | head -5'

# get top process eating cpu ##
alias pscpu='ps auxf | sort -nr -k 3 | head -5'

#####
alias c='clear'
alias ls='ls --color=auto'
alias ll='ls --group-directories-first -l'
alias lls='ls --group-directories-first -lAhX'
alias lss='ls -1AX'
alias cc='. lf'
#'cd "$(cdinto.sh)"'
#'cd $(fd -a --base-directory ~ -H -t d -E ".npm/"|fzf --height=60%)'
alias e='nvim'
alias yt='ytfzf -lt --thumb-viewer=kitty'
alias ytc='ytfzf -lt --thumb-viewer=kitty --type=channel'
alias pdf='opn pdf'
alias mp='opn mpv'
alias eng='evince ~/Documents/04_ENGLISH\ LEARNING/Objective\ General\ English\ by\ S.\ P.\ Bakshi.pdf'
alias open='open.sh'
alias zshrc='nvim $HOME/.config/zsh/.zshrc'
alias hyp='nvim $HOME/.config/hypr/hyprland.conf'
alias source-zsh='source ~/.config/zsh/.zshrc'
alias svn="svn --config-dir \"$XDG_CONFIG_HOME\"/subversion"

alias nvvim="NVIM_APPNAME=NvChad nvim"

alias gs='git status'
alias gp='git push'
alias ga='git add'
