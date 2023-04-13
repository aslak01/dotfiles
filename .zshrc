#!/bin/sh
[ -f "$HOME/.local/share/zap/zap.zsh" ] && source "$HOME/.local/share/zap/zap.zsh"

# history
HISTFILE=~/.zsh_history
HISTORY_IGNORE="(ls|pwd|cd ..|yt_dlp *)"

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
# plug "zap-zsh/zap-prompt"
# plug "zettlrobert/simple-prompt"
# plug "wintermi/zsh-starship"
plug "zap-zsh/fzf"
# plug "zap-zsh/exa"
plug "zsh-users/zsh-syntax-highlighting"

# starship prompt
eval "$(starship init zsh)"

plug "$HOME/.config/zsh/aliases.zsh"

export PATH="$HOME/.local/bin":$PATH

# zsh-autosuggestions
# keybinds
bindkey '^@' autosuggest-accept
# configs
ZSH_AUTOSUGGEST_STRATEGY=(history completion)
ZSH_AUTOSUGGEST_BUFFER_MAX_SIZE=20

if command -v bat &> /dev/null; then
  alias cat="bat -pp --theme \"Visual Studio Dark+\"" 
  alias catt="bat --theme \"Visual Studio Dark+\"" 
fi


# bun completions
[ -s "$HOME/.bun/_bun" ] && source "$HOME/.bun/_bun"
