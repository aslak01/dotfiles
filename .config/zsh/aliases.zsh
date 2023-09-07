alias vim="nvim"
alias g='lazygit'
alias v="vim ."
alias zsh-update-plugins="find "$ZDOTDIR/plugins" -type d -exec test -e '{}/.git' ';' -print0 | xargs -I {} -0 git -C {} pull -q"
alias nvimrc='nvim ~/.config/nvim/'
# alias dotfiles='/usr/bin/git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME'

# alias ls="exa --icons -F"
# alias ll="exa -l --icons -F --color auto .h"
# alias la="exa -a --icons -F"
alias ls="exa -a --icons"
alias lss="exa --icons"

# confirm before overwriting something
alias cp="cp -i"
alias mv='mv -i'
# alias rm='rm -i'

# easier to read disk
alias df='df -h'     # human-readable sizes

# fzf available commands
# https://www.reddit.com/r/commandline/comments/yjg1fb/examplebased_cheat_sheets_from_the_command_line/iunks9b/
alias tldrf='tldr --list | fzf --preview "tldr {1} --color=always" --preview-window=right,70% | xargs tldr'

alias ~="cd ~"
alias ..="cd .."
alias ...="cd ../.."
alias ....="cd ../../.."
alias .....="cd ../../../.."
alias cd..="cd .." # Typo addressed.

alias vimrc="$EDITOR $HOME/.config/nvim/lua/user/init.lua"
alias zshrc="$EDITOR $HOME/dotfiles/.zshrc"
alias zali="$EDITOR $HOME/dotfiles/.config/zsh/aliases.zsh"
alias zfunc="$EDITOR $HOME/dotfiles/.config/zsh/functions.zsh"

alias nocorschrome="open -a Google\ Chrome --args --disable-web-security --user-data-dir='/tmp'"
