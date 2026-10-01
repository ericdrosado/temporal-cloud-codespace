#!/usr/bin/env bash
# Runs once when the Codespace is created. Installs everything inside the container;
# nothing touches the user's own machine.
set -euo pipefail

TEMPORAL_CLI_VERSION="1.9.1"      # https://github.com/temporalio/cli/releases
TEMPORAL_CLOUD_VERSION="0.2.0"    # https://github.com/temporalio/cloud-cli/releases

case "$(uname -m)" in
  x86_64)  arch=amd64 ;;
  aarch64) arch=arm64 ;;
  *) echo "unsupported architecture: $(uname -m)" >&2; exit 1 ;;
esac

tmp="$(mktemp -d)"
trap 'rm -rf "$tmp"' EXIT

# Download a release tarball, verify it against the release's checksums.txt, and
# install the named binary to /usr/local/bin.
install_release() {
  local repo="$1" version="$2" tarball="$3" binary="$4"
  local base="https://github.com/temporalio/${repo}/releases/download/v${version}"
  curl -fsSL -o "$tmp/$tarball" "$base/$tarball"
  curl -fsSL -o "$tmp/$repo.checksums.txt" "$base/checksums.txt"
  (cd "$tmp" && grep " $tarball\$" "$repo.checksums.txt" | sha256sum -c -)
  tar -xzf "$tmp/$tarball" -C "$tmp" "$binary"
  sudo install -m 0755 "$tmp/$binary" "/usr/local/bin/$binary"
}

# The skill calls `temporal cloud ...`: the Temporal CLI dispatches that to the
# temporal-cloud plugin binary on PATH, so both are needed.
install_release cli "$TEMPORAL_CLI_VERSION" "temporal_cli_${TEMPORAL_CLI_VERSION}_linux_${arch}.tar.gz" temporal
install_release cloud-cli "$TEMPORAL_CLOUD_VERSION" "temporal_cloud_cli_${TEMPORAL_CLOUD_VERSION}_linux_${arch}.tar.gz" temporal-cloud

# `temporal cloud login` opens a browser. In a Codespace, $BROWSER points at a helper
# that opens the URL on the user's own computer; route xdg-open to it if no real
# xdg-open exists.
if ! command -v xdg-open >/dev/null 2>&1; then
  sudo install -m 0755 .devcontainer/xdg-open /usr/local/bin/xdg-open
fi

sudo install -m 0755 bin/finish-login /usr/local/bin/finish-login

# Copilot CLI: the agent that runs the skill. Signs in with the user's GitHub account
# and is included with Copilot Free.
npm install -g --silent @github/copilot

temporal --version
temporal cloud --help >/dev/null && echo "temporal cloud plugin: ok"

# The skill's preflight / detect-tools / install-cli steps are skipped in this Codespace
# (see AGENTS.md), so check what they would have checked here, once, at build time.
for bin in git jq python3 go node npm java mvn dotnet ruby bundle; do
  command -v "$bin" >/dev/null || { echo "missing tool: $bin" >&2; exit 1; }
done
config_dir="${XDG_CONFIG_HOME:-$HOME/.config}/temporalio"
mkdir -p "$config_dir" && touch "$config_dir/.probe" && rm -f "$config_dir/.probe"
echo "skill prerequisites: ok"
