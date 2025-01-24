#! /bin/zsh
# zmodload zsh/zprof

# Disable shell sessions
export SHELL_SESSIONS_DISABLE=1

# Load compinit and promptinit
autoload -Uz compinit promptinit

# Initialize compinit with cache
_comp_files=(${ZDOTDIR:-$HOME}/.zcompdump(Nm-20))
if (( $#_comp_files )); then
    compinit -u -i -C
else
    compinit -i
fi
unset _comp_files
promptinit
setopt prompt_subst

# Load colors
autoload -U colors && colors

# ZSH Settings
unsetopt case_glob
setopt globdots
setopt extendedglob
setopt autocd
setopt brace_ccl
setopt combining_chars
setopt rc_quotes
unsetopt mail_warning
setopt long_list_jobs
setopt auto_resume
setopt notify
unsetopt bg_nice
unsetopt hup
unsetopt check_jobs
setopt complete_in_word
setopt always_to_end
setopt path_dirs
setopt auto_menu
setopt auto_list
setopt auto_param_slash
setopt no_complete_aliases

unsetopt menu_complete
unsetopt flow_control
unsetopt beep nomatch
unsetopt correct

# History
HISTFILE="$ZDOTDIR/.zhistory"
HISTORY_IGNORE="(ls|pwd|cd ..|yt-dlp *|nvim .|..|...|....|n *|g|v|z)"
HISTSIZE=10000
SAVEHIST=5000
setopt appendhistory notify
setopt bang_hist
setopt inc_append_history
setopt share_history
setopt hist_expire_dups_first
setopt hist_ignore_dups
setopt hist_ignore_all_dups
setopt hist_find_no_dups
setopt hist_ignore_space
setopt hist_save_no_dups
setopt hist_verify
setopt extended_history

# Edit current command
autoload -Uz edit-command-line
zle -N edit-command-line
bindkey -M vicmd 'vv' edit-command-line

# Zinit
ZINIT_HOME="${XDG_DATA_HOME:-$HOME/.local/share}/zinit/zinit.git"
if [ ! -d "$ZINIT_HOME" ]; then
    mkdir -p "$(dirname $ZINIT_HOME)"
    git clone https://github.com/zdharma-continuum/zinit.git "$ZINIT_HOME"
fi
source "${ZINIT_HOME}/zinit.zsh"

# Compile Zsh files for faster loading
_zsh_files=("$ZDOTDIR/.zshrc" "$ZDOTDIR/.zstyle" "$ZDOTDIR/.zaliases" "$ZDOTDIR/.zfunctions" "$ZDOTDIR/.zinit")

for file in "${_zsh_files[@]}"; do
    if [[ ! -f "${file}.zwc" || "${file}" -nt "${file}.zwc" ]]; then
        zcompile "${file}"
    fi
done
unset _zsh_files

[[ -r "$ZDOTDIR/.zaliases" ]] && source "$ZDOTDIR/.zaliases"
[[ -r "$ZDOTDIR/.zstyle" ]] && source "$ZDOTDIR/.zstyle"
[[ -r "$ZDOTDIR/.zinit" ]] && source "$ZDOTDIR/.zinit"
[[ -r "$ZDOTDIR/.zfunctions" ]] && source "$ZDOTDIR/.zfunctions"
[[ -r "$ZDOTDIR/private_api_keys" ]] && source "$ZDOTDIR/private_api_keys"

eval "$(starship init zsh)"
eval "$(tv init zsh)"

# zprof
