#!/bin/bash
#
# Set default editor
EDITOR="${EDITOR:-nvim}"

RG_CMD="rg --line-number . $HOME/.config $HOME/dotfiles"

fzf_preview="(file -bL --mime-type -- {} | grep -iq 'text') && \
            (bat --style=numbers --color=always {}) || \
            (dirname -- {} | xargs -I {} tree -- {} | head -200)"

export FZF_DEFAULT_COMMAND='fd -Ha \
  --base-directory ~ \
  --type f \
  --exclude={"Applications/","Music/","*.srt","go/",".cache/",".var/",".local/",".mozilla/",".git/",".npm/",".ssh/"}'

export FZF_DEFAULT_OPTS="
  -m
  -d /
  --with-nth=-3..
  --layout=reverse
  --inline-info
  --keep-right
  --delimiter ":"
  --preview '${fzf_preview}'
  --preview-window 'up,wrap,40%,+{2}+3/3,~3'
  --bind 'change:first'
  --bind 'ctrl-/:change-preview-window(hidden|down|right)'
  --bind 'ctrl-r:change-prompt(rg> )+reload($RG_CMD)+change-preview(bat --color=always {1} --highlight-line {2})+clear-query+unbind(tab)'
  --bind 'ctrl-f:change-prompt(fzf> )+reload($FZF_DEFAULT_COMMAND)+change-preview($fzf_preview)+clear-query+rebind(tab)'
  --color='fg:#CDD6F4,fg+:#f9e2af,bg+:-1,pointer:#CDD6F4,gutter:-1'"

if [ "$1" = "hyp" ]; then
	CMD="kitty --detach ${EDITOR}"
	hyp="true"
else
	CMD="${EDITOR}"
fi

# Function to open files
open_file() {
	local textfiles=()

	for file in "$@"; do
		case "$(file --dereference --brief --mime-type -- "${file%%:*}")" in
		text/* | */x-shellscript | */json | inode/x-empty)
			textfiles+=("$file")
			;;
		video/*)
			if [ -n "$hyp" ]; then
				setsid mpv --no-terminal -- "$file" >/dev/null 2>&1 &
				pkill -n $!
			else
				mpv "$file"
			fi
			;;
		*)
			[ -f "$file" ] && setsid xdg-open "$file" &>/dev/null &
			pkill -n $!
			;;
		esac
	done
	case "${#textfiles[@]}" in
	0) return 0 ;;
	1)
		IFS=':' read -r filename linenumber _ <<<"${textfiles[0]}"
		command $CMD "$filename" ${linenumber:+"+$linenumber"}
		;;
	*) command "$CMD" "${textfiles[@]}" ;;
	esac
}

# Check if the first argument is a file
if [ -f "$1" ]; then
	open_file "$@"
else
	IFS=$'\n' readarray -t files < <(fzf)
	open_file "${files[@]}"
fi
