alias vim="nvim"
alias g='lazygit'
alias v="vim ."
alias zsh-update-plugins="find "$ZDOTDIR/plugins" -type d -exec test -e '{}/.git' ';' -print0 | xargs -I {} -0 git -C {} pull -q"
alias nvimrc='nvim ~/.config/nvim/'

alias ls="eza -a --icons"
alias ll="eza -l --icons --color auto"
alias lsnew="eza -l -snew | tail"

alias cat='bat --style=plain'

# confirm before overwriting something
alias cp="cp -i"
alias mv='mv -i'

# easier to read disk
alias df='df -h'     # human-readable sizes

# fzf available commands
# https://www.reddit.com/r/commandline/comments/yjg1fb/examplebased_cheat_sheets_from_the_command_line/iunks9b/
alias tldrf='tldr --list | fzf --preview "tldr {1}" --preview-window=right,70% | xargs tldr'

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

alias nocorschrome="open -a Google\ Chrome --args --disable-web-security --user-data-dir='/tmp/'"
alias nrs="open -a Numbers"

alias mutt="neomutt"

alias sd="cd \$(fd . -t d | fzf)"
