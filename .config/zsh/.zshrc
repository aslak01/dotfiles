#! /usr/bin/env zsh
# shellcheck shell=bash
# zmodload zsh/zprof

source_if_exists() {
    [[ -r "$1" ]] && source "$1"
}

defer_or_eval() {
    # Eval $1 via zsh-defer if available, else inline.
    if (($+functions[zsh - defer])); then
        zsh-defer eval "$1"
    else
        eval "$1"
    fi
}

export SHELL_SESSIONS_DISABLE=1

# Static equivalent of `eval "$(brew shellenv)"` minus path_helper (already run
# by /etc/zprofile on macOS) and PATH (built in the explicit path=() below).
export HOMEBREW_PREFIX="/opt/homebrew"
export HOMEBREW_CELLAR="/opt/homebrew/Cellar"
export HOMEBREW_REPOSITORY="/opt/homebrew"
export INFOPATH="/opt/homebrew/share/info${INFOPATH:+:$INFOPATH}"

fpath=(
    /opt/homebrew/share/zsh/site-functions
    ${ZDOTDIR:-$HOME}/mac-zsh-completions/completions
    $fpath
)

autoload -Uz compinit

# Optimize compinit with better caching logic
if [[ ${ZDOTDIR:-$HOME}/.zcompdump(#qNmh+24) ]]; then
    # Completion dump is stale (> 24h old), rebuild with security checks
    compinit -i -d "${ZDOTDIR:-$HOME}/.zcompdump"
else
    # Completion dump is fresh or missing, load without security checks for speed
    compinit -C -d "${ZDOTDIR:-$HOME}/.zcompdump"
fi

# Apple completions are bash-based and rarely used interactively — defer them
# (below, once zsh-defer is loaded) so bashcompinit doesn't block the prompt.
_load_apple_completions() {
    local dir="${ZDOTDIR:-$HOME/.config/zsh}/apple_complete"
    autoload -Uz bashcompinit && bashcompinit
    for cmd in diskutil hdiutil launchctl networksetup pkgutil installer log; do
        [[ -r "$dir/$cmd" ]] && source "$dir/$cmd"
    done
}

autoload -U colors && colors

# ZSH Settings
# setopt prompt_subst
unsetopt case_glob
setopt globdots
setopt extendedglob
setopt autocd
setopt brace_ccl
setopt long_list_jobs
setopt auto_resume
setopt notify
unsetopt bg_nice
unsetopt hup
unsetopt check_jobs
setopt complete_in_word
setopt always_to_end
setopt auto_param_slash
setopt no_complete_aliases

unsetopt menu_complete
unsetopt flow_control
unsetopt beep
# nomatch
unsetopt correct

# History
HISTFILE="$ZDOTDIR/.zhistory"
HISTORY_IGNORE="(ls|pwd|cd(| *)|yt-dlp *|nvim .|n *|g|v|z|..*|...*|....*)"
HISTSIZE=10000
SAVEHIST=5000
setopt hist_ignore_all_dups hist_expire_dups_first hist_save_no_dups
setopt appendhistory
setopt bang_hist
setopt inc_append_history
setopt share_history
setopt hist_find_no_dups
setopt hist_ignore_space
setopt hist_verify
setopt extended_history
setopt hist_reduce_blanks

if command -v sheldon >/dev/null 2>&1; then
    source "$HOME/.local/share/sheldon/repos/github.com/romkatv/zsh-defer/zsh-defer.plugin.zsh"
    zsh-defer eval "$(sheldon source)"
    # Re-run compinit after plugins load so their fpath additions register.
    zsh-defer compinit -C -d "${ZDOTDIR:-$HOME}/.zcompdump"
    zsh-defer _load_apple_completions
else
    _load_apple_completions
fi

if command -v bob >/dev/null && ! command -v nvim >/dev/null; then
    # Defer so a fresh machine doesn't block the prompt on first launch.
    if (($+functions[zsh - defer])); then
        zsh-defer eval 'bob install stable && bob use stable'
    else
        bob install stable && bob use stable
    fi
fi

if command -v mise >/dev/null; then
    defer_or_eval 'eval "$(mise activate zsh)"'
fi

_zsh_files=("$ZDOTDIR/.zshrc" "$ZDOTDIR/.zstyle" "$ZDOTDIR/.zaliases" "$ZDOTDIR/.zfunctions")

for file in "${_zsh_files[@]}"; do
    if [[ -f "${file}" && (! -f "${file}.zwc" || "${file}" -nt "${file}.zwc") ]]; then
        zcompile "${file}"
    fi
done
unset _zsh_files

source_if_exists "$ZDOTDIR/.zstyle"
source_if_exists "$ZDOTDIR/.zfunctions"
source_if_exists "$ZDOTDIR/private_api_keys"
source_if_exists "$ZDOTDIR/.zaliases"

# this auto dedupes
typeset -U path

path=(
    "/opt/homebrew/bin"                # Homebrew binaries
    "/opt/homebrew/sbin"               # Homebrew system binaries
    "$HOME/.local/bin"                 # homebrewed scripts
    "$HOME/go/bin"                     # Go
    "/opt/homebrew/opt/go/libexec/bin" # Go root
    ${PNPM_HOME:+"$PNPM_HOME"}         # PNPM (skip if unset)
    "$HOME/.bun/bin"                   # Bun
    "$HOME/.deno/bin"                  # Deno
    "$HOME/.cargo/bin"                 # Rust
    "$HOME/.local/share/bob/nvim-bin"  # Bob (Neovim)
    "$HOME/bin"                        # Custom bin
    "$HOME/.dprint/bin"                # Dprint
    $path
)

completions=(
    "$HOME/.bun/_bun"
)

for comp in "${completions[@]}"; do
    source_if_exists "$comp"
done

export STARSHIP_SHELL="zsh"
# Follow macOS dark/light appearance; LS_COLORS still rides the terminal ANSI palette.
export BAT_THEME="auto:system"
export BAT_THEME_DARK="Catppuccin Mocha"
export BAT_THEME_LIGHT="Catppuccin Latte"

load_keychain_cached

if command -v opam >/dev/null; then
    defer_or_eval 'eval "$(opam env --switch=default --set-switch 2>/dev/null)"'
fi

if command -v tv >/dev/null; then
    defer_or_eval 'eval "$(tv init zsh)"'
fi

if command -v starship >/dev/null; then
    # Re-source guard: starship wraps zle-keymap-select on init, so when this
    # rc is re-sourced we strip the previous wrapper to avoid stacking.
    if [[ "${widgets[zle - keymap - select]#user:}" == "starship_zle-keymap-select" ||
        "${widgets[zle - keymap - select]#user:}" == "starship_zle-keymap-select-wrapped" ]]; then
        zle -N zle-keymap-select ""
    fi
    eval "$(starship init zsh)"
fi

if (($+functions[zsh - defer])); then
    zsh-defer source "$HOME/.local/bin/env"
else
    source_if_exists "$HOME/.local/bin/env"
fi

if command -v zsh-patina >/dev/null; then
    eval "$(zsh-patina activate)"
fi
# zprof
