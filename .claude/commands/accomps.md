---
name: git-commits-summary
description: Scans all git repositories in the current working directory, finds commits by the user across ALL local branches, and produces a professional accomplishment report split into 2 summary blocks. Use when the user wants a summary of their git activity across multiple repos — useful for standups, timesheets, or accomplishment reports.
---

# Git Commits Summary Skill

Scans the current working directory for git repositories, extracts commits by the user across **all local branches**, and produces a professional accomplishment report **split into 2 summary blocks** by default.

## When to Use

- User asks to "summarize my commits", "what did I work on", "group my git activity"
- User wants a standup report, timesheet, accomplishment report, or changelog across repos
- User is in a folder containing multiple git repos

## Workflow

1. **Use the current directory**: Always scan the directory Claude is currently running in. Do NOT ask for a folder path.
2. **Identify the author**: Auto-detect by running `git config user.name` or `git config user.email` in any discovered repo. Only ask if auto-detect fails.
3. **Time range is always today**: Automatically use today's date with explicit timestamps: `--since="YYYY-MM-DD 00:00:00" --until="YYYY-MM-DD 23:59:59"`. Do NOT use relative words like "today" — they don't work reliably. Only override if the user explicitly provides a different range.
4. **Identify the summary title**: Infer summary titles from the commit messages. Only ask if the commits are too ambiguous to categorize.
5. **Scan for repos**: Find all directories containing a `.git` folder (up to 3 levels deep) from the current directory.
6. **Extract commits from ALL local branches**: For each repo, run `git log` with `--all` to capture commits across every local branch — the user may not remember which branches they worked on.
7. **Deduplicate**: The same commit may appear in multiple branches. Deduplicate by commit hash.
8. **Split into 2 blocks**: By default, split the accomplishments evenly into **2 summary blocks** (for work reporting that requires 2 blocks). Each block should have its own `[PROJECT – Summary Title]` header. Distribute bullets roughly evenly across the 2 blocks, grouping related work together.
9. **Override to 1 block**: If the user says they "only did half", "just 1 block", or similar, output only 1 block instead.

## Implementation

### Step 1: Extract commits from all local branches

```bash
#!/bin/bash
# Run from the current directory
PARENT_DIR="."
AUTHOR="$(git config user.name 2>/dev/null || echo '')"
SINCE="$(date '+%Y-%m-%d') 00:00:00"
UNTIL="$(date '+%Y-%m-%d') 23:59:59"

repos=$(find "$PARENT_DIR" -maxdepth 3 -name ".git" -type d 2>/dev/null | sed 's/\/.git$//' | sort)

for repo in $repos; do
    repo_name=$(basename "$repo")

    git_args=(-C "$repo" log --all --author="$AUTHOR" --since="$SINCE" --until="$UNTIL" --pretty=format:"%H|%h|%ad|%s" --date=short)

    # Deduplicate by full commit hash, output short hash
    commits=$(git "${git_args[@]}" 2>/dev/null | sort -t'|' -k1,1 -u | cut -d'|' -f2-)

    if [ -n "$commits" ]; then
        echo "=== $repo_name ==="
        echo "$commits"
        echo ""
    fi
done
```

### Step 2: Transform into accomplishment report

After extracting the raw commits, Claude must:
1. Rewrite each commit message into a professional accomplishment bullet highlighting value/impact.
2. **Split the bullets into 2 blocks by default.** Group related work together within each block and give each block a distinct summary title.
3. Only produce 1 block if the user explicitly says they only did half or requests 1 block.

## Output Format — STRICT

ALL output MUST be in a markdown code block so it can be easily copied.

### Default: 2 Blocks

```
[REPO_NAME – Summary Title for Block 1]
- Bullet summarizing accomplishment with value/impact
- Bullet summarizing accomplishment with value/impact

[REPO_NAME – Summary Title for Block 2]
- Bullet summarizing accomplishment with value/impact
- Bullet summarizing accomplishment with value/impact
```

### Override: 1 Block (user said "only did half" or "1 block")

```
[REPO_NAME – Summary Title]
- Bullet summarizing accomplishment with value/impact
- Bullet summarizing accomplishment with value/impact
```

### Example Output (2 Blocks)

```
[ASYS – Outsource Development & Bug Fixes]
- Enhanced outsource workflow performance by optimizing item sorting logic to prioritize first item values, improving processing efficiency for warehouse operations
- Resolved validation constraints in outsource workflow to enable more flexible single-item processing, reducing operational friction for staff
- Fixed default quantity calculation to ensure accurate item counts during workflow initialization, preventing data entry errors

[ASYS – User Service Refactoring & Search Improvements]
- Restructured user service layer to consolidate core operations into a dedicated service, improving code maintainability and reusability
- Added case-insensitive full name matching for user lookups, enhancing search reliability for staff workflows
- Implemented duplicate user detection to surface conflicts early, reducing data integrity issues
```

## Bullet Writing Rules

1. Each bullet must highlight **value** — e.g., improved performance, user experience, maintainability, scalability, reliability, or compliance.
2. If commit messages are vague, infer reasonable value (e.g., stability, clarity, reliability).
3. Bullets must be **straight to the point** — no filler words.
4. Do NOT add extra sections, explanations, or restate instructions.
5. **One bullet per commit** — every commit must have its own bullet. Do NOT group or merge commits together.
6. Use professional language consistent with accomplishment reporting.

## Bullet Categories (for context when rewriting)

- **PR Reviews**: "Conducted code reviews ensuring quality and alignment with project standards"
- **Refactoring**: "Restructured X to enhance scalability and reusability for future features"
- **Bug Fixes**: "Resolved X to improve Y" / "Fixed X preventing Z errors"
- **Feature Development**: "Developed X to provide Y benefit" / "Implemented X for measurable impact"
- **Meetings**: "Collaborated with teams to align on X"

## Key Rules

- **Always default to today** — never ask for a time range. Just run it for today's commits automatically. Only use a different range if the user explicitly says so.
- **Always run from current directory** — never ask the user for a folder path.
- **Always use `--all`** in `git log` to capture commits across every local branch.
- **Always deduplicate** by commit hash since the same commit may exist on multiple branches.
- **Always default to 2 blocks** unless the user says otherwise.
- **Always wrap output in a code block** for easy copying.
- Auto-detect author from `git config user.name` — only ask if detection fails.
