---
name: open-xcode
description: Use when the user asks to open an Xcode workspace or project, including slash-like prompts such as "/open-xcode", "/open-xcode Runner", "open ios", "open xcode", "open Runner", or "open the iOS workspace". Opens the best .xcworkspace/.xcodeproj from the current repository, preferring workspaces over projects.
metadata:
  short-description: Open the right Xcode workspace/project
---

# Open Xcode

When this skill triggers, run the helper immediately. Do not only explain what the user can run.

Use the user's provided workspace/project name as the optional argument. For example, `/open-xcode Runner` should run:

```bash
open-xcode Runner
```

If no name is provided, run:

```bash
open-xcode
```

After running, briefly report the selected path printed by the helper.

Behavior:
- Search from the git repository root when available, otherwise from the current directory.
- Prefer `.xcworkspace` over `.xcodeproj`.
- Prefer Xcode files under `/ios/` over sibling platform folders such as `/macos/`.
- If the user provides a name, match it case-insensitively against workspace/project names and paths.
- If no name is provided, open the most recently used or modified workspace; if no workspace exists, use the most recent project.
- Print the selected path before opening it.

Use `--print` first when you need to verify selection without opening Xcode.
