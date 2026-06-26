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

# ---- package groups -------------------------------------------------------

# Cross-platform
COMMON := nvim git bat btop mise lazygit gnupg lemonade gh kitty ghostty wezterm claude

# macOS-only
MACGUI := aerospace amethyst yabai skhd borders karabiner finicky \
          launchagents smartset qutebrowser mpv yt-dlp neomutt aerc \
          zsh sheldon starship television tigervnc silicon svgo \
          containers lima docker lazydocker 

# ---- profiles -------------------------------------------------------------

MAC    := $(COMMON) $(MACGUI)
SERVER := $(COMMON) bash

# ---- mechanics ------------------------------------------------------------

# --ignore 'settings\.local\.json': Claude Code drops a per-directory
# .claude/settings.local.json into whatever dir it runs in, which lands inside
# packages. Without this, stow maps every stray one onto ~/.claude/settings.local.json
# and aborts with "stowed to a different package". We ignore that filename rather
# than all of .claude/ so the tracked claude package CAN stow ~/.claude/CLAUDE.md.
STOW       := stow --target=$(HOME) --dir=$(CURDIR) --ignore='settings\.local\.json'
STOW_FLAGS ?=

.PHONY: help mac server pi common bashrc-conveniences lemonade-guest YOLOVM yolovm claude-yolo gpg-agent-conf

help:
	@echo "Profiles:  make mac | server | pi | common | YOLOVM"
	@echo "Modifiers: STOW_FLAGS=-n (dry run)  -R (restow)  -D (unlink)"
	@echo
	@echo "  mac    -> $(MAC)"
	@echo "  server -> $(SERVER)"
	@echo "  pi     -> $(PI)"
	@echo "  YOLOVM -> server + 'claude --dangerously-skip-permissions' alias (sandboxed VMs only)"

# mac also writes the bits stow can't link: gpg-agent.conf carries a mac-only
# pinentry-program line (pinentry-mac), so it's generated rather than stowed.
mac:
	$(STOW) $(STOW_FLAGS) $(MAC)
	@$(MAKE) --no-print-directory gpg-agent-conf PINENTRY_MAC=1 STOW_FLAGS='$(STOW_FLAGS)'

# The server profile also configures the bits stow can't link: it sources the
# shared bash config from the real (non-symlinked) ~/.bashrc and provisions
# lemonade so links open on the host. Skipped on dry-run (-n) and unlink (-D).
server:
	$(STOW) $(STOW_FLAGS) $(SERVER)
	@$(MAKE) --no-print-directory bashrc-conveniences lemonade-guest gpg-agent-conf STOW_FLAGS='$(STOW_FLAGS)'

common:
	$(STOW) $(STOW_FLAGS) $(COMMON)
	@$(MAKE) --no-print-directory gpg-agent-conf STOW_FLAGS='$(STOW_FLAGS)'

YOLOVM yolovm: server
	@$(MAKE) --no-print-directory claude-yolo STOW_FLAGS='$(STOW_FLAGS)'

bashrc-conveniences:
	@case " $(STOW_FLAGS) " in *" -n "* | *" -D "*) exit 0 ;; esac; \
	if grep -q 'bashrc-conveniences' "$$HOME/.bashrc" 2>/dev/null; then \
	  echo "~/.bashrc already sources .bashrc-conveniences"; \
	else \
	  printf '\n# dotfiles: load shared bash config\n. "$$HOME/.bashrc-conveniences"\n' >>"$$HOME/.bashrc"; \
	  echo "added '. ~/.bashrc-conveniences' to ~/.bashrc"; \
	fi

# Provision lemonade on the guest: build the binary natively (go is available
# via mise) and install the xdg-open shim that forwards link-opens to the host
# Safari daemon. Idempotent — only does work when something is missing.
lemonade-guest:
	@case " $(STOW_FLAGS) " in *" -n "* | *" -D "*) exit 0 ;; esac; \
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
	    >"$$HOME/.local/bin/xdg-open" && \
	  chmod +x "$$HOME/.local/bin/xdg-open" && \
	  echo "installed ~/.local/bin/xdg-open"; \
	else \
	  echo "~/.local/bin/xdg-open already installed"; \
	fi

# Append the YOLO claude alias to the real ~/.bashrc. Idempotent. The global
# ~/.claude/CLAUDE.md is handled by the stowed `claude` package, not here.
claude-yolo:
	@case " $(STOW_FLAGS) " in *" -n "* | *" -D "*) exit 0 ;; esac; \
	if grep -q 'alias claude=' "$$HOME/.bashrc" 2>/dev/null; then \
	  echo "~/.bashrc already aliases claude"; \
	else \
	  printf '%s\n' \
	    '' \
	    '# YOLO: skip Claude Code permission prompts (sandboxed VMs only)' \
	    "alias claude='claude --dangerously-skip-permissions'" \
	    >>"$$HOME/.bashrc"; \
	  echo "added 'claude --dangerously-skip-permissions' alias to ~/.bashrc"; \
	fi

# Generate ~/.gnupg/gpg-agent.conf as a REAL file (not a stow symlink) so the
# mac-only pinentry-program line can be appended without leaking onto the other
# hosts. Base cache settings everywhere; the pinentry-mac line only when called
# with PINENTRY_MAC=1 (the mac profile). Idempotent; skipped on -n/-D. Replaces
# any stale stow symlink left over from when this file was a stow package member.
gpg-agent-conf:
	@case " $(STOW_FLAGS) " in *" -n "* | *" -D "*) exit 0 ;; esac; \
	conf="$$HOME/.gnupg/gpg-agent.conf"; \
	install -d -m 700 "$$HOME/.gnupg"; \
	if [ -L "$$conf" ]; then rm "$$conf"; fi; \
	if [ ! -f "$$conf" ]; then \
	  printf '%s\n' \
	    'default-cache-ttl 28800 # A workday' \
	    'max-cache-ttl 86400     # A day' \
	    >"$$conf"; \
	  echo "wrote $$conf"; \
	fi; \
	if [ -n "$(PINENTRY_MAC)" ]; then \
	  if grep -q 'pinentry-program' "$$conf" 2>/dev/null; then \
	    echo "gpg-agent.conf already sets pinentry-program"; \
	  else \
	    printf 'pinentry-program /opt/homebrew/bin/pinentry-mac\n' >>"$$conf"; \
	    echo "added pinentry-mac to $$conf"; \
	  fi; \
	fi
