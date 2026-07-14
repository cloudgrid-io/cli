#!/bin/sh
# CloudGrid CLI installer
# https://github.com/cloudgrid-io/cli
#
# Installs @cloudgrid-io/cli via npm. Requires Node 18+.
# Usage:
#   curl -fsSL https://raw.githubusercontent.com/cloudgrid-io/cli/main/install.sh | sh
#
# Pin a version:
#   CLOUDGRID_VERSION=0.9.13 sh install.sh
#
# SPDX-License-Identifier: Apache-2.0

set -eu

PACKAGE="@cloudgrid-io/cli"
VERSION="${CLOUDGRID_VERSION:-latest}"

# ---------- helpers ----------------------------------------------------------

log()  { printf '[cloudgrid] %s\n' "$*"; }
err()  { printf '[cloudgrid] ERROR: %s\n' "$*" >&2; }
die()  { err "$@"; exit 1; }

need_cmd() {
  command -v "$1" >/dev/null 2>&1 || return 1
}

# ---------- preflight --------------------------------------------------------

# Node is required.
if ! need_cmd node; then
  err "Node.js is not installed."
  err ""
  err "CloudGrid CLI requires Node 18 or later. Install Node from one of:"
  err "  https://nodejs.org/"
  err "  brew install node          (macOS)"
  err "  nvm install --lts          (nvm)"
  err "  volta install node         (volta)"
  err ""
  die "Install Node, then re-run this script."
fi

# Node 18+ is required.
NODE_MAJOR=$(node -e 'process.stdout.write(String(process.versions.node.split(".")[0]))')
if [ "$NODE_MAJOR" -lt 18 ] 2>/dev/null; then
  die "Node $NODE_MAJOR found, but Node 18 or later is required. Please upgrade Node."
fi

# npm must be available (ships with Node).
if ! need_cmd npm; then
  die "npm not found. It ships with Node -- check your Node installation."
fi

# ---------- install ----------------------------------------------------------

log "Installing ${PACKAGE}@${VERSION} ..."
npm install -g "${PACKAGE}@${VERSION}"

# ---------- post-install -----------------------------------------------------

# Check that the binary is on PATH.
if need_cmd cloudgrid; then
  INSTALLED_VERSION=$(grid --version 2>/dev/null || echo "unknown")
  log "Installed: cloudgrid ${INSTALLED_VERSION}"
else
  NPM_BIN=$(npm bin -g 2>/dev/null || npm prefix -g 2>/dev/null | xargs -I{} printf '%s/bin' {})
  log "Installed, but 'cloudgrid' is not on your PATH."
  log "Add the npm global bin directory to your PATH:"
  log ""
  log "  export PATH=\"${NPM_BIN}:\$PATH\""
  log ""
  log "Then open a new terminal or run the export above."
fi

# Claude Code detection — nudge only, never auto-install.
if need_cmd claude; then
  log "Claude Code is installed. Build with claude and ship to CloudGrid — ask it to deploy a directory or drop a file."
else
  log "Claude Code is not installed. It pairs with CloudGrid to build and ship from one place. Install: curl -fsSL https://claude.ai/install.sh | bash  (docs: https://code.claude.com/docs/en/overview)."
fi

log ""
log "Uninstall: npm uninstall -g ${PACKAGE}"
