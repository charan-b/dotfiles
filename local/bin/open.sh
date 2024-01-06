#!/bin/bash
#
# Set default editor
EDITOR="${EDITOR:-nvim}"

# Function to open files
open_file() {
	local textfiles=()
	local videos=()
	for file in "$@"; do
		case "$(file --dereference --brief --mime-type -- "${file%%:*}")" in
		text/* | */x-shellscript | */json | inode/x-empty)
			textfiles+=("$file")
			;;
		video/*)
			videos+=("$file")
			;;
		*)
			[ -f "$file" ] && setsid xdg-open "$file" &>/dev/null &
			pkill -n $!
			;;
		esac
	done

	if [ "${hyp}" == "true" ]; then

		if [ ${#videos[@]} -ge 1 ]; then
			setsid mpv "${videos[@]}" &>/dev/null &
			pkill -n $!
		fi

		case "${#textfiles[@]}" in
		0) return 0 ;;
		1)
			IFS=':' read -r filename linenumber _ <<<"${textfiles[0]}"
			setsid command foot ${EDITOR} "$filename" ${linenumber:+"+$linenumber"} &
			pkill -n $!
			;;
		*)
			command foot ${EDITOR} "${textfiles[@]}"
			;;
		esac

	else

		if [ ${#videos[@]} -ge 1 ]; then
			mpv "${videos[@]}" &>/dev/null
		fi

		case "${#textfiles[@]}" in
		0) return 0 ;;
		1)
			IFS=':' read -r filename linenumber _ <<<"${textfiles[0]}"
			command ${EDITOR} "$filename" ${linenumber:+"+$linenumber"}
			;;
		*)
			command "${EDITOR}" "${textfiles[@]}"
			;;
		esac

	fi

}

fzf_finder() {

	RG_CMD="rg --line-number . $HOME/.config $HOME/dotfiles"
	VID='fd -Ha --base-directory ~ --type f . ~/Videos/'
	DOC='fd -Ha --base-directory ~ --type f . ~/Documents/'

	fzf_preview="(file -bL --mime-type -- {} | grep -iq 'text') && \
            (bat --style=numbers --color=always {}) || \
            (dirname -- {} | xargs -I {} tree -- {} | head -200)"

	export FZF_DEFAULT_COMMAND='fd -Ha \
    --base-directory ~ \
    --type f \
    --exclude={"Applications/","Music/","*.srt","go/",".cache/",".var/",".local/",".mozilla/",".git/",".npm/",".ssh/","git_repos/"}'

	export FZF_DEFAULT_OPTS="
  -m
  -d /
  --with-nth=-3..
  --layout=reverse
  --info=inline-right
  --keep-right
  --delimiter ":"
  --preview '${fzf_preview}'
  --preview-window 'up,wrap,40%,+{2}+3/3,~3'
  --bind 'change:first'
  --color='fg:#CDD6F4,fg+:#f9e2af,bg+:-1,pointer:#CDD6F4,gutter:-1'
  --bind 'ctrl-/:change-preview-window(hidden|down|right|up)'
  --bind 'ctrl-r:change-prompt(rg: )+reload($RG_CMD)+change-preview(bat --color=always {1} --highlight-line {2})+clear-query+unbind(tab)'
  --bind 'ctrl-f:change-prompt(fzf: )+reload($FZF_DEFAULT_COMMAND)+change-preview($fzf_preview)+clear-query+rebind(tab)'
  --bind 'ctrl-v:change-prompt(videos: )+reload($VID)+change-preview($fzf_preview)+clear-query+rebind(tab)'
  --bind 'ctrl-d:change-prompt(Docs: )+reload($DOC)+change-preview($fzf_preview)+clear-query+rebind(tab)'"

	IFS=$'\n' readarray -t files < <(fzf)
	open_file "${files[@]}"
}

if [ "$1" = "hyp" ]; then
	hyp="true"
	fzf_finder
elif [ -f "$1" ]; then
	open_file "$@"
else
	fzf_finder
fi
