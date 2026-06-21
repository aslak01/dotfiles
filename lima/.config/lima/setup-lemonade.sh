#!/usr/bin/env bash
# Configure lemonade in an already-provisioned Claude VM.
#
# Provision the VM however you like (e.g. `limactl start ~/.config/lima/cvm.yaml`).
# Then run this to wire up link-opening — it does NOT create or start the VM.
# Idempotent: safe to re-run.
set -euo pipefail

INSTANCE="${1:-cvm}"

# Cross-compile lemonade for the guest and forward link-opens onward to the
# work Mac's Safari daemon. Path:
#   cvm xdg-open -> personal Mac :2490 (host.lima.internal)
#                -> ssh -R 2490 reverse tunnel -> work Mac :2490 -> Safari
# Port 2489 is reserved for the work Mac's Firefox daemon (SSH work hosts), so
# the cvm uses 2490 to keep its opens in Safari instead. The work→personal SSH
# must carry `RemoteForward 2490 localhost:2490` for this to reach anything.
sync_lemonade() {
  if ! command -v go >/dev/null 2>&1; then
    echo "go not found on host — cannot build lemonade." >&2
    return 1
  fi
  # Match the guest architecture (aarch64 -> arm64, x86_64 -> amd64).
  local guest_arch goarch
  guest_arch="$(limactl shell "$INSTANCE" uname -m)"
  case "$guest_arch" in
  aarch64 | arm64) goarch="arm64" ;;
  x86_64 | amd64) goarch="amd64" ;;
  *)
    echo "unknown guest arch '$guest_arch' — cannot build lemonade." >&2
    return 1
    ;;
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

# Require an existing instance — this script configures, it does not provision.
if ! limactl list --quiet | grep -qx "$INSTANCE"; then
  echo "instance '$INSTANCE' not found. Provision it first, e.g.:" >&2
  echo "  limactl start ~/.config/lima/cvm.yaml" >&2
  echo "then re-run: $0 [instance-name]" >&2
  exit 1
fi

sync_lemonade
