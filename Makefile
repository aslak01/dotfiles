# Modular dotfiles — GNU stow packages grouped into per-host profiles.
#
# Each subdirectory here is a stow "package" whose contents mirror $HOME.
# A profile is just a list of packages. Stow only what a given host needs.
#
# Usage:
#   make mac          # link the macOS workstation profile into $HOME
#   make server       # link the server profile
#   make pi           # link the minimal Raspberry Pi profile
#   make mac STOW_FLAGS=-n   # DRY RUN — show what would happen, change nothing
#   make mac STOW_FLAGS=-R   # restow (refresh links, prune stale ones)
#   make mac STOW_FLAGS=-D   # unlink the profile
#
# Tune the package lists below to taste — they're starting points.

# ---- package groups -------------------------------------------------------

# Cross-platform CLI: safe on macOS, Linux servers, and Raspberry Pis.
COMMON := nvim git bat btop mise lazygit gnupg lemonade 

# macOS-only: window managers, GUI apps, launch agents, hardware configs.
MACGUI := aerospace amethyst yabai skhd borders karabiner finicky \
          launchagents smartset qutebrowser mpv kitty ghostty wezterm \
          tigervnc silicon svgo lima containers \
	  docker lazydocker \
	  zsh sheldon yt-dlp gh starship television neomutt aerc 

# ---- profiles -------------------------------------------------------------

MAC    := $(COMMON) $(MACGUI)
SERVER := $(COMMON)
PI     := $(COMMON)

# ---- mechanics ------------------------------------------------------------

STOW       := stow --target=$(HOME) --dir=$(CURDIR)
STOW_FLAGS ?=

.PHONY: help mac server pi common

help:
	@echo "Profiles:  make mac | server | pi | common"
	@echo "Modifiers: STOW_FLAGS=-n (dry run)  -R (restow)  -D (unlink)"
	@echo
	@echo "  mac    -> $(MAC)"
	@echo "  server -> $(SERVER)"
	@echo "  pi     -> $(PI)"

mac:
	$(STOW) $(STOW_FLAGS) $(MAC)

server:
	$(STOW) $(STOW_FLAGS) $(SERVER)

pi:
	$(STOW) $(STOW_FLAGS) $(PI)

common:
	$(STOW) $(STOW_FLAGS) $(COMMON)
