#!/usr/bin/env zsh

export ZSH_PLUGIN_DIR="$HOME/.local/share/zsh/plugins"

# Source Plugins
# copied from zap-zsh/zap plugin manager
plug() {

    [[ -f "$1" ]] && source "$1" && return

    local plugin="$1"
    local plugin_name="${plugin:t}"
    local plugin_dir=$ZSH_PLUGIN_DIR/$plugin_name

    _try_source() {
        local -a initfiles=(
            $plugin_dir/${plugin_name}.{plugin.,}{z,}sh{-theme,}(N)
            $plugin_dir/*.{plugin.,}{z,}sh{-theme,}(N)
        )
        (( $#initfiles )) && source $initfiles[1]
    }

    if [[ ! -d "$plugin_dir" ]]; then
        echo "$plugin_name: installing..."
        git clone --depth 1 "${ZAP_GITHUB_PREFIX:-"https://"}github.com/${plugin}.git" "$plugin_dir" > /dev/null 2>&1
        [[  $? -eq 0 ]] && { echo -e "\e[1A\e[K $plugin_name: installed!" } || echo -e "\e[1A\e[K $plugin_name: Failed to clone!"
    fi
    _try_source || echo " $plugin_name not activated" && return
}

# Update Plugins
update-plugins() {
    for _plug in $ZSH_PLUGIN_DIR/* ; do
        _plug_name=${_plug:t}
        echo -e "\e[K $_plug_name: updating.."
        git -C $_plug pull > /dev/null 2>&1
        [[  $? -eq 0 ]] && { echo -e "\e[1A\e[K $_plug_name: updated!" } || echo -e "\e[1A\e[K $_plug_name: Failed to pull"
    done
}
