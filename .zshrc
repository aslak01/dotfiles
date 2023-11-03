#!/bin/sh
[ -f "$HOME/.local/share/zap/zap.zsh" ] && source "$HOME/.local/share/zap/zap.zsh"

# history
HISTFILE=~/.zsh_history
HISTORY_IGNORE="(ls|pwd|cd ..|yt-dlp *)"

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

export PATH="$HOME/.local/bin":$PATH

# zsh-autosuggestions
# keybinds
bindkey '^@' autosuggest-accept
# configs
ZSH_AUTOSUGGEST_STRATEGY=(history completion)
ZSH_AUTOSUGGEST_BUFFER_MAX_SIZE=20

# bun completions
[ -s "$HOME/.bun/_bun" ] && source "$HOME/.bun/_bun"

# z
eval "$(zoxide init zsh)"

#deno
export DENO_INSTALL="$HOME/.deno"
export PATH="$DENO_INSTALL/bin:$PATH"

# bun completions
[ -s "/Users/aslakbakkeland/.bun/_bun" ] && source "/Users/aslakbakkeland/.bun/_bun"

export PATH="$HOME/.yarn/bin:$HOME/.config/yarn/global/node_modules/.bin:$PATH"
export PATH="$HOME/.local/share/bob/nvim-bin:$PATH"


