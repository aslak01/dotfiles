#!/bin/zsh

# Init ghostty

# if [ -d "${GHOSTTY_RESOURCES_DIR}" ]; then
#     builtin source "${GHOSTTY_RESOURCES_DIR}/shell-integration/zsh/ghostty-integration"
# fi

# Zsh core config 

export SHELL_SESSIONS_DISABLE=1

# Compinit

# Load the prompt system and completion system and initilize them.
autoload -Uz compinit promptinit

# Load and initialize the completion system ignoring insecure directories with a
# cache time of 20 hours, so it should almost always regenerate the first time a
# shell is opened each day.
# See: https://gist.github.com/ctechols/ca1035271ad134841284
_comp_files=(${ZDOTDIR:-$HOME}/.zcompdump(Nm-20))
if (( $#_comp_files )); then
    compinit -i -C
else
    compinit -i
fi
unset _comp_files
promptinit
setopt prompt_subst

# - - - - - - - - - - - - - - - - - - - -
# ZSH Settings
# - - - - - - - - - - - - - - - - - - - -

autoload -U colors && colors    # Load colors.
unsetopt case_glob              # Use case-insensitve globbing.
setopt globdots                 # Glob dotfiles as well.
setopt extendedglob             # Use extended globbing.
setopt autocd                   # Automatically change directory if a directory is entered.

# Smart URLs.
autoload -Uz url-quote-magic
zle -N self-insert url-quote-magic

# General.
setopt brace_ccl                # Allow brace character class list expansion.
setopt combining_chars          # Combine zero-length punctuation characters ( accents ) with the base character.
setopt rc_quotes                # Allow 'Henry''s Garage' instead of 'Henry'\''s Garage'.
unsetopt mail_warning           # Don't print a warning message if a mail file has been accessed.

# Jobs.
setopt long_list_jobs           # List jobs in the long format by default.
setopt auto_resume              # Attempt to resume existing job before creating a new process.
setopt notify                   # Report status of background jobs immediately.
unsetopt bg_nice                # Don't run all background jobs at a lower priority.
unsetopt hup                    # Don't kill jobs on shell exit.
unsetopt check_jobs             # Don't report on jobs when shell exit.

setopt correct                  # Turn on corrections

# Completion Options.
setopt complete_in_word         # Complete from both ends of a word.
setopt always_to_end            # Move cursor to the end of a completed word.
setopt path_dirs                # Perform path search even on command names with slashes.
setopt auto_menu                # Show completion menu on a successive tab press.
setopt auto_list                # Automatically list choices on ambiguous completion.
setopt auto_param_slash         # If completed parameter is a directory, add a trailing slash.
setopt no_complete_aliases

setopt menu_complete            # Do not autoselect the first completion entry.
unsetopt flow_control           # Disable start/stop characters in shell editor.

# Zstyle.

zstyle ':completion:*:*:*:*:*' menu select
zstyle ':completion:*:matches' group 'yes'
zstyle ':completion:*:options' description 'yes'
zstyle ':completion:*:options' auto-description '%d'
zstyle ':completion:*:corrections' format ' %F{green}-- %d (errors: %e) --%f'
zstyle ':completion:*:descriptions' format ' %F{yellow}-- %d --%f'
zstyle ':completion:*:messages' format ' %F{purple} -- %d --%f'
zstyle ':completion:*:warnings' format ' %F{red}-- no matches found --%f'
zstyle ':completion:*:default' list-prompt '%S%M matches%s'
zstyle ':completion:*' format ' %F{yellow}-- %d --%f'
zstyle ':completion:*' group-name ''
zstyle ':completion:*' verbose yes
zstyle ':completion::complete:*' use-cache on
zstyle ':completion::complete:*' cache-path "$HOME/.zcompcache"
zstyle ':completion:*' list-colors $LS_COLORS
zstyle ':completion:*:*:kill:*:processes' list-colors '=(#b) #([0-9]#) ([0-9a-z-]#)*=01;34=0=01'
zstyle ':completion:*' matcher-list 'm:{a-zA-Z}={A-Za-z}' 'r:|[._-]=* r:|=*' 'l:|=* r:|=*'
zstyle ':completion:*:functions' ignored-patterns '(_*|pre(cmd|exec))'
zstyle ':completion:*' rehash true


# History

HISTFILE="$ZDOTDIR/.zhistory"
HISTORY_IGNORE="(ls|pwd|cd ..|yt-dlp *|nvim .|..|...|....|n *|g|v|z)"
HISTSIZE=10000
SAVEHIST=5000
setopt appendhistory notify
unsetopt beep nomatch

setopt bang_hist                # Treat the '!' character specially during expansion.
setopt inc_append_history       # Write to the history file immediately, not when the shell exits.
setopt share_history            # Share history between all sessions.
setopt hist_expire_dups_first   # Expire a duplicate event first when trimming history.
setopt hist_ignore_dups         # Do not record an event that was just recorded again.
setopt hist_ignore_all_dups     # Delete an old recorded event if a new event is a duplicate.
setopt hist_find_no_dups        # Do not display a previously found event.
setopt hist_ignore_space        # Do not record an event starting with a space.
setopt hist_save_no_dups        # Do not write a duplicate event to the history file.
setopt hist_verify              # Do not execute immediately upon history expansion.
setopt extended_history         # Show timestamp in history.

# zinit

ZINIT_HOME="${XDG_DATA_HOME:-${HOME}/.local/share}/zinit/zinit.git"

# Download Zinit, if it's not there yet
if [ ! -d "$ZINIT_HOME" ]; then
   mkdir -p "$(dirname $ZINIT_HOME)"
   git clone https://github.com/zdharma-continuum/zinit.git "$ZINIT_HOME"
fi

source "${ZINIT_HOME}/zinit.zsh"



# Load .zstyles file with customizations.
if [[ -r "$ZDOTDIR/.zstyles" ]]; then
    source "$ZDOTDIR/.zstyles"
fi

# Add aliases.
# if [[ -r "$ZDOTDIR/.zaliases" ]]; then
#     source "$ZDOTDIR/.zaliases"
# fi

# source
if [[ -r "$ZDOTDIR/private_api_keys" ]]; then
    source "$ZDOTDIR/private_api_keys"
fi

# if [[ -r "$ZDOTDIR/functions.zsh" ]]; then
#     source "$ZDOTDIR/functions.zsh"
# fi


# Edit current command
autoload -Uz edit-command-line
zle -N edit-command-line
bindkey -M vicmd 'vv' edit-command-line

# zsh-autosuggestions
# keybinds
bindkey '^f' autosuggest-accept

alias vim='nvim'
alias g='lazygit'
alias v='vim .'

alias nocorschrome='open -a Google| Chrome --args --disable-web-security --user-data-dir="/tmp/"'
alias nrs='open -a Numbers'
alias mutt='neomutt'

alias ls='eza -a --icons'
alias ll='eza -l --icons --color auto'
alias lsnew='eza -l -snew | tail'

alias cat='bat --style=plain'

# easier to read disk
alias df='df -h'     # human-readable sizes

# fzf available commands
# https://www.reddit.com/r/commandline/comments/yjg1fb/examplebased_cheat_sheets_from_the_command_line/iunks9b/
alias tldrf='tldr --list | fzf --preview "tldr {1}" --preview-window=right,70% | xargs tldr'

# # fzf lower down dirs
# alias sd="cd \$(fd . -t d | fzf)"

# alias ~='cd ~'
alias ..='cd ..'
alias ...='cd ../..'
alias ....='cd ../../..'
alias .....='cd ../../../..'
alias cd..='cd ..' # Typo 

alias zshrc="vim $HOME/.zshrc"
alias nvimrc="vim $HOME/.config/nvim/"


############## path shit
# version managed Node
export N_CACHE_PREFIX="$HOME/n"
if [ -d $N_CACHE_PREFIX ]; then
    [[ :$PATH: == *":$N_CACHE_PREFIX/bin:"* ]] || PATH+=":$N_CACHE_PREFIX/bin"
fi

export GOPATH="$HOME/go"
if [ -d $GOPATH ]; then
    [[ :$PATH: == *":$GOPATH/bin:"* ]] || PATH+=":$GOPATH/bin"
fi

export GOROOT="$(brew --prefix golang)/libexec"
if [ -d "$GOROOT" ]; then
    [[ :$PATH: == *":$GOROOT/bin:"* ]] || PATH+=":$GOROOT/bin"
fi

_path_files=(${ZDOTDIR:-$HOME}/path-apps/*)
if (( $#_path_files )); then
    for file in "$_path_files"; do
        echo "sourcing $file"
        [[ -s "${file}" ]] && . "${file}"
    done
fi

export PNPM_HOME="$HOME/Library/pnpm/"
case ":$PATH:" in
  *":$PNPM_HOME:"*) ;;
  *) export PATH="$PNPM_HOME:$PATH" ;;
esac

############## end path shit

# zoxide
if command -v zoxide &> /dev/null; then
    eval "$(zoxide init zsh)"
fi
