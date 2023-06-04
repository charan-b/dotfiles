[ -f "$ZDOTDIR/plugin-manager.zsh" ] && source "$ZDOTDIR/plugin-manager.zsh"

# History configurations
HISTFILE="$HOME/.config/zsh/.zsh_history"
HISTSIZE=10000
SAVEHIST=20000

setopt hist_expire_dups_first # delete duplicates first when HISTFILE size exceeds HISTSIZE
setopt hist_ignore_dups       # ignore duplicated commands history list
setopt hist_ignore_space      # ignore commands that start with space
setopt hist_verify            # show command with history expansion to user before running it
setopt share_history          # share command history data
setopt appendhistory
setopt interactivecomments    # allow comments in interactive mode
setopt magicequalsubst        # enable filename expansion for arguments of the form ‘anything=expression’
setopt nonomatch              # hide error message if there is no match for the pattern
setopt notify                 # report the status of background jobs immediately
setopt numericglobsort        # sort filenames numerically when it makes sense
setopt promptsubst            # enable command substitution in prompt
setopt MENU_COMPLETE          # Automatically highlight first element of completion menu
setopt AUTO_LIST              # Automatically list choices on ambiguous completion.
setopt COMPLETE_IN_WORD       # Complete from both ends of a word.
unsetopt BEEP                 # beeping is annoying
setopt autocd extendedglob nomatch menucomplete
setopt interactive_comments

stty stop undef		# Disable ctrl-s to freeze terminal.
zle_highlight=('paste:none')

eval "$(dircolors -b)"         # for LS_COLORS

# add files
plug "$ZDOTDIR/exports.zsh"
plug "$ZDOTDIR/functions.zsh"
plug "$ZDOTDIR/aliases.zsh"
plug "$ZDOTDIR/prompt.zsh"
plug "$ZDOTDIR/fzf/fzf.zsh"
plug "$ZDOTDIR/keybinds.zsh"
# plug "$ZDOTDIR/fzf/fzf-git.sh"

# enable completion features
autoload -Uz compinit
compinit -i
_comp_options+=(globdots)		# Include hidden files.
zstyle ':completion:*:*:*:*:*' menu select    # show menu           
zstyle ':completion:*' matcher-list 'm:{a-zA-Z}={A-Za-z}' # case insensitive tab completion
zstyle ':completion:*' matcher-list '' 'm:{a-zA-Z}={A-Za-z}' 'r:|[._-]=* r:|=*' 'l:|=* r:|=*' # complete partial words
zstyle ':completion:*' use-cache on   # use cache
zstyle ':completion:*' cache-path "$XDG_CACHE_HOME/zsh/.zcompcache" # cache file
# Define completers
zstyle ':completion:*' completer _extensions _complete _approximate
zstyle ':completion:*:*:*:*:corrections' format '%F{yellow}!- %d (errors: %e) -!%f'
zstyle ':completion:*:*:*:*:descriptions' format '%F{blue}-- %D %d --%f'
zstyle ':completion:*:*:*:*:messages' format ' %F{purple} -- %d --%f'
zstyle ':completion:*:*:*:*:warnings' format ' %F{red}-- no matches found --%f'
zstyle ':completion:*' group-name ''
zstyle ':completion:*:default' list-colors ${(s.:.)LS_COLORS}
# Only display some tags for the command cd
zstyle ':completion:*:*:cd:*' tag-order local-directories directory-stack path-directories
zmodload zsh/complist
bindkey -M menuselect 'h' vi-backward-char
bindkey -M menuselect 'k' vi-up-line-or-history
bindkey -M menuselect 'j' vi-down-line-or-history
bindkey -M menuselect 'l' vi-forward-char

# Plugins
plug "zsh-users/zsh-autosuggestions"
plug "zsh-users/zsh-syntax-highlighting"
plug "hlissner/zsh-autopair"
