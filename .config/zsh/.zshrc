#! /usr/bin zsh
# shellcheck shell=bash
# zmodload zsh/zprof
#
source_if_exists() {
    [[ -r "$1" ]] && source "$1"
}

# Disable shell sessions
export SHELL_SESSIONS_DISABLE=1

# Load compinit and promptinit
autoload -Uz compinit promptinit

_comp_files="(${ZDOTDIR:-$HOME}/.zcompdump(Nm-20))"  # Should be _comp_files, not *comp*files

# only run compinit once per day:
if [[ -n ${ZDOTDIR:-$HOME}/.zcompdump(#qN.mh+24) ]]; then
    compinit -i -C  
else
    compinit -i
fi

unset _comp_files

promptinit

# setopt prompt_subst

# Load colors
autoload -U colors && colors

# ZSH Settings
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
setopt appendhistory notify
setopt bang_hist
setopt inc_append_history
setopt share_history
setopt hist_find_no_dups
setopt hist_ignore_space
setopt hist_verify
setopt extended_history
setopt hist_reduce_blanks

# mise
source_if_exists "$ZDOTDIR/.zmise"



# Zinit
ZINIT_HOME="${XDG_DATA_HOME:-$HOME/.local/share}/zinit/zinit.git"
if [ ! -d "$ZINIT_HOME" ]; then
    mkdir -p "$(dirname "$ZINIT_HOME")"
    git clone https://github.com/zdharma-continuum/zinit.git "$ZINIT_HOME"
fi
source_if_exists "${ZINIT_HOME}/zinit.zsh"


# Compile Zsh files for faster loading
_zsh_files=("$ZDOTDIR/.zshrc" "$ZDOTDIR/.zstyle" "$ZDOTDIR/.zaliases" "$ZDOTDIR/.zfunctions" "$ZDOTDIR/.zinit" "$ZDOTDIR/.zmise")

for file in "${_zsh_files[@]}"; do
    if [[ ! -f "${file}.zwc" || "${file}" -nt "${file}.zwc" ]]; then
        zcompile "${file}"
    fi
done
unset _zsh_files

source_if_exists "$ZDOTDIR/.zstyle"
source_if_exists "$ZDOTDIR/.zinit"
source_if_exists "$ZDOTDIR/.zfunctions"
source_if_exists "$ZDOTDIR/private_api_keys"
source_if_exists "$ZDOTDIR/.zaliases"


# zprof



# update wezterm tab titles
# function precmd() {
#     print -Pn "\e]0;${PWD:t}\a"
# }

# default to using gnu find for linux compatibility (when installed)
if command -v gfind >/dev/null 2>&1; then
    PATH=$(brew --prefix)/opt/findutils/libexec/gnubin:$PATH
fi

# this auto dedupes
typeset -U path

path=(
    "$HOME/.local/bin"                 # homebrewed scripts
    "$HOME/go/bin"                     # Go
    "/opt/homebrew/opt/go/libexec/bin" # Go root
    "$PNPM_HOME"                       # PNPM
    "$HOME/.bun/bin"                   # Bun
    "$HOME/.deno/bin"                  # Deno
    "$HOME/.cargo/bin"                 # Rust
    "$HOME/.local/share/bob/nvim-bin"  # Bob (Neovim)
    "$HOME/bin"                        # Custom bin
    "$HOME/.dprint/bin"                # Dprint
    $path
)

# for dir in "${paths[@]}"; do
#     add_to_path_if_present "$dir"
# done

completions=(
    "$HOME/.bun/_bun"
)

for comp in "${completions[@]}"; do
    source_if_present "$comp"
done



configure_themes


export STARSHIP_SHELL="zsh"

unalias zi 2>/dev/null

load_keychain_cached

# ocaml
command -v opam >/dev/null && eval $(opam env --switch=default --set-switch 2>/dev/null)

# copy terminfo on ssh connect
# "i'm helping"
[ "$TERM" = "xterm-kitty" ] && alias ssh="kitty +kitten ssh"

# export PATH="/opt/homebrew/sbin:/opt/homebrew/bin:$PATH"
command -v tv >/dev/null && eval "$(tv init zsh)"

if command -v starship >/dev/null; then
    if [[ "${widgets[zle-keymap-select]#user:}" == "starship_zle-keymap-select" ||
          "${widgets[zle-keymap-select]#user:}" == "starship_zle-keymap-select-wrapped" ]]; then
        zle -N zle-keymap-select ""
    fi
    eval "$(starship init zsh)"
fi
