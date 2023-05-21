#!/bin/sh

create() {
  [ -f "$file" ] && echo "file already exist" && exit
  touch "$file"
	chmod +x "$file"
  echo "#!/bin/sh" > "$file"
  echo "" >> "$file"
  echo "" >> "$file"
	$EDITOR +3 "$file"
}
echo -n "Give File Name: "
read -r f_name
[[ $1 == "here" ]] && file="$(pwd)/$f_name" || file="$HOME/.local/bin/$f_name"
[ -n "$f_name" ] && create
