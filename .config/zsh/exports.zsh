#!/bin/sh
# HISTFILE="$XDG_DATA_HOME"/zsh/history
HISTSIZE=1000000
SAVEHIST=1000000
export EDITOR="nvim"
export TERMINAL="wezterm"
export BROWSER="safari"

# dotfiles
export XDG_CONFIG_HOME="$HOME/.config"

# Homebrew
export PATH="$HOME/.local/bin":$PATH

# pnpm
export PNPM_HOME="$HOME/Library/pnpm/"
export PATH=$PNPM_HOME:$PATH

# bun
export PATH="$HOME/.bun/bin:$PATH"
# bun completions
[ -s "$HOME/.bun/_bun" ] && source "$HOME/.bun/_bun"

# n (n-install)
export N_PREFIX="$HOME/n"; [[ :$PATH: == *":$N_PREFIX/bin:"* ]] || PATH+=":$N_PREFIX/bin"

# deno
export DENO_INSTALL="$HOME/.deno"
export PATH="$DENO_INSTALL/bin:$PATH"

# yarn
export PATH="$HOME/.yarn/bin:$HOME/.config/yarn/global/node_modules/.bin:$PATH"

# bob (nvim)
export PATH="$HOME/.local/share/bob/nvim-bin:$PATH"

# go
export PATH="$HOME/go/bin:$PATH"
