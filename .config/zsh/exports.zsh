#!/bin/sh
# HISTFILE="$XDG_DATA_HOME"/zsh/history
HISTSIZE=1000000
SAVEHIST=1000000
export EDITOR="nvim"
export TERMINAL="iterm2"
export BROWSER="safari"


# Brew
export PATH=/opt/homebrew/sbin/:$PATH
export PATH=/opt/homebrew/bin:$PATH

# PNPM
export PATH=$HOME/Library/pnpm/:$PATH

# bun
export PATH="$HOME/.bun/bin:$PATH"

# bun completions
[ -s "$HOME/.bun/_bun" ] && source "$HOME/.bun/_bun"

# iterm2
test -e "${HOME}/.iterm2_shell_integration.zsh" && source "${HOME}/.iterm2_shell_integration.zsh"

