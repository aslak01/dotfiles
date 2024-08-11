alias vim="nvim"
alias g='lazygit'
alias v="vim ."

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

alias zshrc="$EDITOR $HOME/.zshrc"
alias nvimrc="$EDITOR $HOME/.config/nvim/"

alias nocorschrome="open -a Google\ Chrome --args --disable-web-security --user-data-dir='/tmp/'"
alias nrs="open -a Numbers"

alias mutt="neomutt"

alias sd="cd \$(fd . -t d | fzf)"


echo "I'm the shell and I also reached this point"
