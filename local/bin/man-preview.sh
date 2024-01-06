#!/bin/bash

preview() {
	man -- "${1%% *}" 2>/dev/null
}
export -f preview

selection=$(man -k . |
	sort - |
	fzf -q "${*}" \
		--cycle \
		--border=none \
		--bind change:first \
		--bind esc:cancel+clear-selection \
		--reverse \
		--preview='sh -c "preview {}"' \
		--preview-window=down:70%:wrap:border-rounded,wrap)

if [[ "${?}" = 0 ]]; then
	man -- "${selection%% *}"
fi
