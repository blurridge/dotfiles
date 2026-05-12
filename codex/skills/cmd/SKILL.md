---
name: cmd
description: Manual invocation only. Use when explicitly invoked as $cmd to improve project agent guidance files such as AGENTS.md or CLAUDE.md.
---

# Improve Agent Guidance

Use this skill to improve repository guidance files for coding agents.

Workflow:

1. Inspect the repository for existing guidance files, preferring `AGENTS.md`, then `CLAUDE.md`, then other obvious agent instruction files.
2. Read the current file and nearby project docs before editing.
3. Preserve useful project-specific instructions and remove stale, duplicated, vague, or tool-incompatible guidance.
4. Prefer concrete instructions that are easy for a coding agent to follow: commands, paths, conventions, test expectations, and safety constraints.
5. Keep tool-specific instructions only when they are intentionally scoped to that tool.
6. If no guidance file exists, create `AGENTS.md` unless the project already clearly standardizes on another filename.

Treat any context after `$cmd` as the requested improvement goal.
