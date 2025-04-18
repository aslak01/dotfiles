#! /usr/bin zsh
# shellcheck shell=bash
# zmodload zsh/zprof

# Disable shell sessions
export SHELL_SESSIONS_DISABLE=1

# Load compinit and promptinit
autoload -Uz compinit promptinit

# Initialize compinit with cache
_comp_files="(${ZDOTDIR:-$HOME}/.zcompdump(Nm-20))"
if (( $#_comp_files )); then
    compinit -u -i -C
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
# setopt path_dirs
# setopt auto_menu
# setopt auto_list
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

# Zinit
ZINIT_HOME="${XDG_DATA_HOME:-$HOME/.local/share}/zinit/zinit.git"
if [ ! -d "$ZINIT_HOME" ]; then
    mkdir -p "$(dirname $ZINIT_HOME)"
    git clone https://github.com/zdharma-continuum/zinit.git "$ZINIT_HOME"
fi

# mise
eval "$(mise activate zsh)"

export STARSHIP_SHELL="zsh"

source "${ZINIT_HOME}/zinit.zsh"
unalias zi 2>/dev/null

# Compile Zsh files for faster loading
_zsh_files=("$ZDOTDIR/.zshrc" "$ZDOTDIR/.zstyle" "$ZDOTDIR/.zaliases" "$ZDOTDIR/.zfunctions" "$ZDOTDIR/.zinit")

for file in "${_zsh_files[@]}"; do
    if [[ ! -f "${file}.zwc" || "${file}" -nt "${file}.zwc" ]]; then
        zcompile "${file}"
    fi
done
unset _zsh_files

[[ -r "$ZDOTDIR/.zstyle" ]] && source "$ZDOTDIR/.zstyle"
[[ -r "$ZDOTDIR/.zinit" ]] && source "$ZDOTDIR/.zinit"
[[ -r "$ZDOTDIR/.zfunctions" ]] && source "$ZDOTDIR/.zfunctions"
[[ -r "$ZDOTDIR/private_api_keys" ]] && source "$ZDOTDIR/private_api_keys"
[[ -r "$ZDOTDIR/.zaliases" ]] && source "$ZDOTDIR/.zaliases"

eval "$(tv init zsh)"

# zprof

configure_themes

# vim mode bug workaround: https://github.com/starship/starship/issues/3418#issuecomment-2477375663
if [[ "${widgets[zle-keymap-select]#user:}" == "starship_zle-keymap-select" || \
      "${widgets[zle-keymap-select]#user:}" == "starship_zle-keymap-select-wrapped" ]]; then
    zle -N zle-keymap-select "";
fi

eval "$(starship init zsh)"

# bun completions
[ -s "/Users/t991563/.bun/_bun" ] && source "/Users/t991563/.bun/_bun"


# update wezterm tab titles
function precmd() {
  print -Pn "\e]0;${PWD:t}\a"
}


# default to using gnu find for linux compatibility (when installed)
if command -v gfind >/dev/null 2>&1; then
  PATH=$(brew --prefix)/opt/findutils/libexec/gnubin:$PATH
fi

# pnpm
export PNPM_HOME="/Users/t991563/.local/share/pnpm"
case ":$PATH:" in
  *":$PNPM_HOME:"*) ;;
  *) export PATH="$PNPM_HOME:$PATH" ;;
esac
# pnpm end
