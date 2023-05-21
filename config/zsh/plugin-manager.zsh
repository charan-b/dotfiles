#!/usr/bin/env zsh

export ZSH_PLUGIN_DIR="$HOME/.local/share/zsh/plugins"
export -a ZSH_INSTALLED_PLUGINS=()

#Source Files
source-file() {
    [[ -f "$1" ]] && source "$1"
}

#Source Plugins
source-plugin() {
    local plugin="$1"
    local plugin_name="${plugin:t}"
    local plugin_dir=$ZSH_PLUGIN_DIR/$plugin_name

    _try_source() {
        typeset -a extensions=(".plugin.zsh" ".zsh-theme" ".zsh")
        for ext in "${extensions[@]}"; do
            [[ -e "$plugin_dir/$plugin_name$ext" ]] && source "$plugin_dir/$plugin_name$ext" && return 0
            [[ -e "$plugin_dir/${plugin_name#zsh-}$ext" ]] && source "$plugin_dir/${plugin_name#zsh-}$ext" && return 0
            # If the plugin file has a different name than $plugin_name
            plugin_filename=$(command ls $plugin_dir | grep $ext)
            [[ -n $plugin_filename ]] && [[ $(echo $plugin_filename | wc -l) -eq 1 ]] && source "$plugin_dir/$plugin_filename" && return 0
        done
    }

    if [[ ! -d "$plugin_dir" ]]; then
        echo "installing $plugin_name..."
        git clone "${ZAP_GITHUB_PREFIX:-"https://"}github.com/${plugin}.git" "$plugin_dir" > /dev/null 2>&1
        [[  $? -eq 0 ]] && echo -e "\e[1A\e[K⚡ installed $plugin_name" || echo -e "\e[1A\e[K❌ Failed to clone $plugin_name"
    fi
    _try_source && { ZSH_INSTALLED_PLUGINS+="$plugin_name" && return 0 } || echo "❌ $plugin_name not activated" && return
}

#Update Plugins
update-plugins() {
    for _plug in ${ZSH_INSTALLED_PLUGINS[@]}; do
        echo "updating $_plug..."
        git -C $ZSH_PLUGIN_DIR/$_plug pull > /dev/null 2>&1 && { echo -e "\e[1A\e[K⚡ ${1:t} updated!"; return 0 } || { echo -e "\e[1A\e[K❌ Failed to pull"; return 14 }
    done

}

#List Plugins
function plugin_list() {
    local _plugin
    echo "⚡ plugin - List\n"
    for _plugin in ${ZSH_INSTALLED_PLUGINS[@]}; do
        printf '%4s  %s\n' $ZSH_INSTALLED_PLUGINS[(Ie)$_plugin] $_plugin
    done
}

#Cleans Unused Plugins
function _zap_clean() {
    typeset -a unused_plugins=()
    echo "Plugin - Clean\n"
    for plugin in "$ZSH_PLUGIN_DIR"/*; do
        [[ "$ZSH_INSTALLED_PLUGINS[(Ie)${plugin:t}]" -eq 0 ]] && unused_plugins+=("${plugin:t}")
    done
    [[ ${#unused_plugins[@]} -eq 0 ]] && { echo "✅ Nothing to remove"; return 15 }
    for plug in ${unused_plugins[@]}; do
        echo "❔ Remove: $plug? (y/N)"
        read -qs answer
        [[ "$answer" == "y" ]] && { rm -rf "$ZAP_PLUGIN_DIR/$plug" && echo -e "\e[1A\e[K✅ Removed $plug" } || echo -e "\e[1A\e[K❕ skipped $plug"
    done
}
