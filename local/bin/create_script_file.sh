#!/bin/sh

create() {
	[ -f "$file" ] && echo "file already exist" && exit
	touch "$file"
	chmod +x "$file"
	echo "#!/bin/sh" >"$file"
	echo "" >>"$file"
	echo "" >>"$file"
	$EDITOR +3 "$file"
}
printf "%s" "Give File Name: "
read -r f_name
[ -n "$f_name" ] || exit 1

case "$1" in
here)
	file="$(pwd)/$f_name"
	;;
fzf)
	file="$(fd --type d | fzf)$f_name"
	;;
/*)
	[ -d "$1" ] && file="$1/$f_name"
	;;
*)
	file="$HOME/.local/bin/$f_name"
	;;
esac
[ -n "$file" ] && create
