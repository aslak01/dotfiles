#!/bin/sh
[ -f "$HOME/.local/share/zap/zap.zsh" ] && source "$HOME/.local/share/zap/zap.zsh"


# history
HISTFILE=~/.zsh_history

# source
plug "$HOME/.config/zsh/aliases.zsh"
plug "$HOME/.config/zsh/exports.zsh"
plug "$HOME/.config/zsh/functions.zsh"
plug "$HOME/.config/zsh/supercharge_no_ls.zsh"

# plugins
plug "wintermi/zsh-brew"
plug "zsh-users/zsh-autosuggestions"
plug "hlissner/zsh-autopair"
# plug "zap-zsh/supercharge"
plug "zap-zsh/vim"
plug "zap-zsh/zap-prompt"
plug "zap-zsh/fzf"
# plug "zap-zsh/exa"
plug "zsh-users/zsh-syntax-highlighting"


export PATH="$HOME/.local/bin":$PATH

if command -v bat &> /dev/null; then
  alias cat="bat -pp --theme \"Visual Studio Dark+\"" 
  alias catt="bat --theme \"Visual Studio Dark+\"" 
fi

# zsh-autosuggestions
# keybinds
bindkey '^ ' autosuggest-accept
# configs
ZSH_AUTOSUGGEST_STRATEGY=(history completion)
ZSH_AUTOSUGGEST_BUFFER_MAX_SIZE=20

# pnpm
export PNPM_HOME="/Users/aslakbakkeland/Library/pnpm"
export PATH="$PNPM_HOME:$PATH"
# pnpm end