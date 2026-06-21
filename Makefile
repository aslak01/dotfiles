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
SERVER := $(COMMON) bash
PI     := $(COMMON)

# ---- mechanics ------------------------------------------------------------

STOW       := stow --target=$(HOME) --dir=$(CURDIR)
STOW_FLAGS ?=

.PHONY: help mac server pi common bashrc-conveniences lemonade-guest YOLOVM yolovm claude-yolo

help:
	@echo "Profiles:  make mac | server | pi | common | YOLOVM"
	@echo "Modifiers: STOW_FLAGS=-n (dry run)  -R (restow)  -D (unlink)"
	@echo
	@echo "  mac    -> $(MAC)"
	@echo "  server -> $(SERVER)"
	@echo "  pi     -> $(PI)"
	@echo "  YOLOVM -> server + 'claude --dangerously-skip-permissions' alias (sandboxed VMs only)"

mac:
	$(STOW) $(STOW_FLAGS) $(MAC)

# The server profile also configures the bits stow can't link: it sources the
# shared bash config from the real (non-symlinked) ~/.bashrc and provisions
# lemonade so links open on the host. Skipped on dry-run (-n) and unlink (-D).
server:
	$(STOW) $(STOW_FLAGS) $(SERVER)
	@$(MAKE) --no-print-directory bashrc-conveniences lemonade-guest STOW_FLAGS='$(STOW_FLAGS)'

pi:
	$(STOW) $(STOW_FLAGS) $(PI)

common:
	$(STOW) $(STOW_FLAGS) $(COMMON)

# YOLOVM: the full server setup plus a claude alias that skips Claude Code's
# permission prompts. Intended only for disposable/sandboxed VMs — it removes
# the safety gate, so never use it on a machine you care about.
YOLOVM yolovm: server
	@$(MAKE) --no-print-directory claude-yolo STOW_FLAGS='$(STOW_FLAGS)'

# Ensure ~/.bashrc sources ~/.bashrc-conveniences. The real ~/.bashrc is a
# regular file (not a stow symlink), so we append the source line rather than
# linking it.
bashrc-conveniences:
	@case " $(STOW_FLAGS) " in *" -n "*|*" -D "*) exit 0 ;; esac; \
	if grep -q 'bashrc-conveniences' "$$HOME/.bashrc" 2>/dev/null; then \
	  echo "~/.bashrc already sources .bashrc-conveniences"; \
	else \
	  printf '\n# dotfiles: load shared bash config\n. "$$HOME/.bashrc-conveniences"\n' >> "$$HOME/.bashrc"; \
	  echo "added '. ~/.bashrc-conveniences' to ~/.bashrc"; \
	fi

# Provision lemonade on the guest: build the binary natively (go is available
# via mise) and install the xdg-open shim that forwards link-opens to the host
# Safari daemon. Idempotent — only does work when something is missing.
lemonade-guest:
	@case " $(STOW_FLAGS) " in *" -n "*|*" -D "*) exit 0 ;; esac; \
	install -d "$$HOME/.local/bin"; \
	if [ ! -x "$$HOME/.local/bin/lemonade" ]; then \
	  if command -v go >/dev/null 2>&1; then \
	    echo "building lemonade..."; \
	    go install github.com/lemonade-command/lemonade@latest && \
	    gobin="$$(go env GOBIN)"; [ -n "$$gobin" ] || gobin="$$(go env GOPATH)/bin"; \
	    cp "$$gobin/lemonade" "$$HOME/.local/bin/lemonade" && \
	    echo "installed ~/.local/bin/lemonade"; \
	  else \
	    echo "go not found — skipping lemonade build (or run ~/.config/lima/setup-lemonade.sh from the host)"; \
	  fi; \
	else \
	  echo "lemonade already installed"; \
	fi; \
	if [ ! -x "$$HOME/.local/bin/xdg-open" ]; then \
	  printf '%s\n' \
	    '#!/bin/bash' \
	    '# Forward URL/file opens to the host lemonade daemon (Safari, port 2490).' \
	    'exec lemonade --host host.lima.internal --port 2490 open "$$@"' \
	    > "$$HOME/.local/bin/xdg-open" && \
	  chmod +x "$$HOME/.local/bin/xdg-open" && \
	  echo "installed ~/.local/bin/xdg-open"; \
	else \
	  echo "~/.local/bin/xdg-open already installed"; \
	fi

# Append the YOLO claude alias to the real ~/.bashrc. Idempotent.
claude-yolo:
	@case " $(STOW_FLAGS) " in *" -n "*|*" -D "*) exit 0 ;; esac; \
	if grep -q 'alias claude=' "$$HOME/.bashrc" 2>/dev/null; then \
	  echo "~/.bashrc already aliases claude"; \
	else \
	  printf '%s\n' \
	    '' \
	    '# YOLO: skip Claude Code permission prompts (sandboxed VMs only)' \
	    "alias claude='claude --dangerously-skip-permissions'" \
	    >> "$$HOME/.bashrc"; \
	  echo "added 'claude --dangerously-skip-permissions' alias to ~/.bashrc"; \
	fi
