#!/usr/bin/env bash
set -euo pipefail

raw_base="${OPEN_XCODE_RAW_BASE:-https://raw.githubusercontent.com/OwaisQuadri/open-xcode/main}"
bin_dir="${OPEN_XCODE_BIN_DIR:-$HOME/.local/bin}"

# Needs a real Xcode.app (any version) to open projects with.
if ! mdfind "kMDItemCFBundleIdentifier == 'com.apple.dt.Xcode'" 2>/dev/null | grep -q . &&
   ! ls -d /Applications/Xcode*.app >/dev/null 2>&1; then
  echo "No Xcode found. Install Xcode (any version) from the App Store, then re-run." >&2
  exit 1
fi

# Works from a local clone (./install.sh) or piped from curl (no repo on disk).
repo_dir=""
if [[ -f "${BASH_SOURCE[0]:-}" ]]; then
  candidate="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
  [[ -f "$candidate/bin/open-xcode" ]] && repo_dir="$candidate"
fi

fetch() {
  local rel="$1" dest="$2" mode="$3"
  mkdir -p "$(dirname "$dest")"
  if [[ -n "$repo_dir" ]]; then
    install -m "$mode" "$repo_dir/$rel" "$dest"
  else
    curl -fsSL "$raw_base/$rel" -o "$dest"
    chmod "$mode" "$dest"
  fi
}

fetch bin/open-xcode "$bin_dir/open-xcode" 755
echo "Installed $bin_dir/open-xcode"

if [[ -d "$HOME/.claude" ]]; then
  fetch claude/skills/open-xcode/SKILL.md "$HOME/.claude/skills/open-xcode/SKILL.md" 644
  fetch claude/commands/open-xcode.md "$HOME/.claude/commands/open-xcode.md" 644
  echo "Installed Claude Code skill (~/.claude/skills/open-xcode) and /open-xcode command"
fi

case ":$PATH:" in
  *":$bin_dir:"*) ;;
  *) echo "NOTE: $bin_dir is not on your PATH. Add this to your shell profile:"
     echo "  export PATH=\"$bin_dir:\$PATH\"" ;;
esac
