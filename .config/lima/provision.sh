#!/usr/bin/env bash
# Start the Claude VM and sync host config into it.
#
# The VM runs with `mounts: []` (full isolation), so files are pushed in with
# `limactl copy` AFTER boot rather than mounted. Git config is read live from
# the host at setup time — its content is never embedded in this repo, only the
# copy command below lives in git.
set -euo pipefail

INSTANCE="cvm"
YAML="${HOME}/.config/lima/claude-vm.yaml"

# Cross-compile lemonade for the guest and forward link-opens onward to the
# work Mac's Safari daemon. Path:
#   cvm xdg-open -> personal Mac :2490 (host.lima.internal)
#                -> ssh -R 2490 reverse tunnel -> work Mac :2490 -> Safari
# Port 2489 is reserved for the work Mac's Firefox daemon (SSH work hosts), so
# the cvm uses 2490 to keep its opens in Safari instead. The work→personal SSH
# must carry `RemoteForward 2490 localhost:2490` for this to reach anything.
# Idempotent: safe to re-run on an existing instance.
sync_lemonade() {
  if ! command -v go >/dev/null 2>&1; then
    echo "go not found on host — skipping lemonade sync into VM." >&2
    return 0
  fi
  # Match the guest architecture (aarch64 -> arm64, x86_64 -> amd64).
  local guest_arch goarch
  guest_arch="$(limactl shell "$INSTANCE" uname -m)"
  case "$guest_arch" in
    aarch64|arm64) goarch="arm64" ;;
    x86_64|amd64)  goarch="amd64" ;;
    *) echo "unknown guest arch '$guest_arch' — skipping lemonade sync." >&2; return 0 ;;
  esac

  GOOS=linux GOARCH="$goarch" go install github.com/lemonade-command/lemonade@latest
  local bin="$(go env GOPATH)/bin/linux_${goarch}/lemonade"

  limactl shell "$INSTANCE" mkdir -p .local/bin
  limactl copy "$bin" "${INSTANCE}:.local/bin/lemonade"
  limactl shell "$INSTANCE" bash -s <<'GUEST'
set -e
chmod +x ~/.local/bin/lemonade
cat > ~/.local/bin/xdg-open <<'EOF'
#!/bin/bash
# Forward URL/file opens to the work Mac's Safari lemonade daemon (port 2490)
# via the personal Mac and the ssh -R 2490 reverse tunnel.
exec lemonade --host host.lima.internal --port 2490 open "$@"
EOF
chmod +x ~/.local/bin/xdg-open
if ! grep -q 'lemonade: open links on the host' ~/.bashrc 2>/dev/null; then
cat >> ~/.bashrc <<'EOF'

# lemonade: open links on the host (macOS) instead of inside the VM
export BROWSER="$HOME/.local/bin/xdg-open"
alias open='xdg-open'
EOF
fi
GUEST
  echo "lemonade synced into VM — links open on the host."
}

# Existing instance: just (re)start it — config is already in place.
if limactl list --quiet | grep -qx "$INSTANCE"; then
  limactl start "$INSTANCE"
  sync_lemonade
  echo "VM '$INSTANCE' is up."
  exit 0
fi

# Fresh instance: provision it, then sync host git config in once.
limactl start --name "$INSTANCE" "$YAML"
limactl shell "$INSTANCE" mkdir -p .config
limactl copy --recursive "${HOME}/.config/git" "${INSTANCE}:.config/"
sync_lemonade
echo "VM '$INSTANCE' provisioned and git config synced."
