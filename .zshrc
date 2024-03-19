#!/bin/sh
[ -f "$HOME/.local/share/zap/zap.zsh" ] && source "$HOME/.local/share/zap/zap.zsh"

# history
HISTFILE=~/.zsh_history
HISTORY_IGNORE="(ls|pwd|cd ..|yt-dlp *)"

LANG=no_NO.UTF-8

# source
plug "$HOME/.config/zsh/exports.zsh"
plug "$HOME/.config/zsh/functions.zsh"
plug "$HOME/.config/zsh/zsh_api_keys.zsh"

# plugins
plug "wintermi/zsh-brew"
plug "zsh-users/zsh-autosuggestions"
plug "hlissner/zsh-autopair"
plug "zap-zsh/supercharge"
plug "zap-zsh/vim"
plug "zap-zsh/fzf"
plug "zsh-users/zsh-syntax-highlighting"

# starship prompt
eval "$(starship init zsh)"

plug "$HOME/.config/zsh/aliases.zsh"

# zsh-autosuggestions
# keybinds
bindkey '^@' autosuggest-accept

# configs
ZSH_AUTOSUGGEST_STRATEGY=(history completion)
ZSH_AUTOSUGGEST_BUFFER_MAX_SIZE=20

# z
eval "$(zoxide init zsh)"

# fzf
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

