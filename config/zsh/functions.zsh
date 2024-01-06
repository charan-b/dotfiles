# 'ls' after changing directory
function cd() {
	builtin cd "$@" && command ls --group-directories-first --color=auto -F
}

# custom function top used commands
function toppy() {
    history | awk '{CMD[$2]++;count++;}END { for (a in CMD)print CMD[a] " " CMD[a]/count*100 "% " a;}' | grep -v "./" | column -c3 -s " " -t | sort -nr | nl |  head -n 21
}

# LF as cd
function lfcd () {
    tmp="$(mktemp)"
    # `command` is needed in case `lfcd` is aliased to `lf`
    command lf -last-dir-path="$tmp" "$@"
    if [ -f "$tmp" ]; then
        dir="$(cat "$tmp")"
        rm -f "$tmp"
        if [ -d "$dir" ]; then
            if [ "$dir" != "$(pwd)" ]; then
                cd "$dir"
            fi
        fi
    fi
}

copy-line () {
rg --line-number . | fzf --delimiter ':' --preview 'bat --color=always --highlight-line {2} {1}' --preview-window 'up,60%,border-bottom,+{2}+3/3,~3'| awk -F ':' '{print $3}' | sed 's/^\s+//' | wl-copy
}

open-line () {
nvim $(rg --line-number .|fzf --delimiter ':' --preview 'bat --color=always --highlight-line {2} {1}' --preview-window 'up,60%,border-bottom,+{2}+3/3,~3'|awk -F ':' '{print "+"$2" "$1}') 
}


function take {
    mkdir -p $1
    cd $1
}

wifi ()
{
  if [[ "$#" -eq 1 ]]; then
    nmcli device wifi connect $1 2>/dev/null
    if [[ "$?" -eq "4" ]]; then
      printf "enter password: "
      read -r pass
      nmcli device wifi connect "$1" password "$pass"
    fi

  elif [[ "$#" -eq 2 ]]; then
    nmcli device wifi connect $1 password $2
  else
    nmcli device wifi
  fi
}

function nvims() {
  items=("default" "kickstart" "LazyVim" "NvChad" "AstroNvim")
  config=$(printf "%s\n" "${items[@]}" | fzf --prompt=" Neovim Config  " --height=~50% --layout=reverse --border --exit-0)
  if [[ -z $config ]]; then
    echo "Nothing selected"
    return 0
  elif [[ $config == "default" ]]; then
    config=""
  fi
  NVIM_APPNAME=$config nvim $@
}

git-pull() {
  [ -n "$1" ] && git_dir="$1" || git_dir="$HOME/Applications"
  fd --search-path "$git_dir" --regex ".git$" -H -t d -x echo {//}|while read name;do
  echo "updating git $name"
  git -C $name pull
  echo ""
done
}

alert() {
  local exit_status=$?
  notify-send "Finished!!" "Finished Executing Command With\n Exit Code: $exit_status "
}

gpt() {
  printf "tgpt: \n\n"
  read input
  tgpt "$input"
}
