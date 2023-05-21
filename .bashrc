#!/bin/bash
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

[ -f ~/.config/bash/prompt ] && . "$HOME"/.config/bash/prompt
[ -f ~/.config/bash/aliases ] && . "$HOME"/.config/bash/aliases
[ -f ~/.config/bash/exports ] && . "$HOME"/.config/bash/exports
[ -f ~/.config/bash/functions ] && . "$HOME"/.config/bash/functions
