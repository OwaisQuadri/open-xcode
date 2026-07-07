---
description: Open the best Xcode workspace/project in the current repo
argument-hint: "[workspace-or-project-name]"
allowed-tools: Bash(open-xcode:*)
---

Run:

```bash
open-xcode "$ARGUMENTS"
```

Run it immediately when invoked, then report the selected path printed by the command.

It searches from the current git repository root, prefers `.xcworkspace` over `.xcodeproj`, prefers `/ios/` over sibling platform folders, and falls back to the best available Xcode project file.
