# XDG Base Directory Specification
export ZDOTDIR=${ZDOTDIR:-$HOME/.config/zsh}
export XDG_CONFIG_HOME=${XDG_CONFIG_HOME:-$HOME/.config}
export XDG_CACHE_HOME=${XDG_CACHE_HOME:-$HOME/.cache}
export XDG_DATA_HOME=${XDG_DATA_HOME:-$HOME/.local/share}
export XDG_STATE_HOME=${XDG_STATE_HOME:-$HOME/.local/state}
export XDG_RUNTIME_DIR=${XDG_RUNTIME_DIR:-$HOME/.xdg}
export XDG_PROJECTS_DIR=${XDG_PROJECTS_DIR:-$HOME/w}

if [[ -f "/opt/homebrew/bin/brew" ]]; then
  export HOMEBREW_PREFIX="/opt/homebrew"
  export HOMEBREW_CELLAR="/opt/homebrew/Cellar"
  export HOMEBREW_REPOSITORY="/opt/homebrew"
  export PATH="/opt/homebrew/bin:/opt/homebrew/sbin:${PATH}"
  export MANPATH="/opt/homebrew/share/man${MANPATH+:$MANPATH}:"
  export INFOPATH="/opt/homebrew/share/info:${INFOPATH:-}"
fi

# Docker
export DOCKER_HOST="unix://$HOME/.config/colima/default/docker.sock"

# Defaults
export LANG=en_US.UTF-8
export LC_COLLATE=C
export TERMINAL="kitty"
export BROWSER="open"
export EDITOR="nvim"
export GIT_EDITOR="nvim"
