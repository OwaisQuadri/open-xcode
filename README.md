# open-xcode

Open the right Xcode workspace or project from anywhere in a repo — no more hunting through Finder or typing long paths.

```bash
open-xcode            # opens the best workspace/project in the current repo
open-xcode Runner     # opens the workspace/project matching "Runner"
open-xcode --print    # print the selection without opening Xcode
open-xcode --list     # list all candidates, best match first
open-xcode -n Runner  # same as positional name, as a flag
open-xcode -f ~/code  # search only that folder (no git-root expansion)
open-xcode --help     # full usage
```

## How it picks

- Searches from the git repo root (falls back to the current directory), skipping `Pods`, `build`, `DerivedData`, etc.
- Prefers `.xcworkspace` over `.xcodeproj` (so CocoaPods/Flutter repos open the right thing).
- Prefers files under `/ios/` over sibling platform folders like `/macos/`.
- With a name argument, matches it case-insensitively against workspace/project names and paths.
- Ties break by most recently used (Spotlight's last-used date, falling back to modification time).

## Install

Requires macOS (uses `open`, `mdls`, and BSD `stat`).

One-liner:

```bash
curl -fsSL https://raw.githubusercontent.com/OwaisQuadri/open-xcode/main/install.sh | bash
```

Or from a clone:

```bash
git clone https://github.com/OwaisQuadri/open-xcode.git
cd open-xcode
./install.sh
```

Or with Homebrew:

```bash
brew install owaisquadri/tap/open-xcode
```

The installer puts the `open-xcode` script in `~/.local/bin` (override with `OPEN_XCODE_BIN_DIR`). If you use [Claude Code](https://claude.com/claude-code), it also installs a skill and a `/open-xcode` slash command so you can say "open the iOS workspace" or run `/open-xcode Runner` from any session. (Homebrew installs only the script; run the installer for the Claude Code extras.)

## Environment

- `OPEN_XCODE_ROOT` — search from this directory instead of the current one.
