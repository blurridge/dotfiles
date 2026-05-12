---
name: accomps
description: Manual invocation only. Use when explicitly invoked as $accomps to summarize today's local git commits into professional accomplishment blocks.
---

# Git Commits Summary

Scan all git repositories in the current working directory, find commits by the user across all local branches, and produce a professional accomplishment report split into two summary blocks by default.

## Workflow

1. Use the current directory. Do not ask for a folder path.
2. Auto-detect the author from `git config user.name` or `git config user.email` in a discovered repo. Ask only if detection fails.
3. Use today's date with explicit timestamps:
   - `--since="YYYY-MM-DD 00:00:00"`
   - `--until="YYYY-MM-DD 23:59:59"`
4. Scan for repositories with `.git` folders up to 3 levels deep.
5. Extract commits from all local branches with `git log --all`.
6. Deduplicate commits by full hash.
7. Rewrite each commit into one professional accomplishment bullet that highlights value or impact.
8. Split into two blocks by default, with distinct `[PROJECT - Summary Title]` headers.
9. If the user says they only did half, only need one block, or requests one block, output one block.

## Extraction Script

```bash
PARENT_DIR="."
AUTHOR="$(git config user.name 2>/dev/null || echo '')"
SINCE="$(date '+%Y-%m-%d') 00:00:00"
UNTIL="$(date '+%Y-%m-%d') 23:59:59"

repos=$(find "$PARENT_DIR" -maxdepth 3 -name ".git" -type d 2>/dev/null | sed 's/\/.git$//' | sort)

for repo in $repos; do
    repo_name=$(basename "$repo")
    git_args=(-C "$repo" log --all --author="$AUTHOR" --since="$SINCE" --until="$UNTIL" --pretty=format:"%H|%h|%ad|%s" --date=short)
    commits=$(git "${git_args[@]}" 2>/dev/null | sort -t'|' -k1,1 -u | cut -d'|' -f2-)

    if [ -n "$commits" ]; then
        echo "=== $repo_name ==="
        echo "$commits"
        echo ""
    fi
done
```

## Output Format

All output must be in a markdown code block.

Default:

```text
[REPO_NAME - Summary Title for Block 1]
- Bullet summarizing accomplishment with value/impact
- Bullet summarizing accomplishment with value/impact

[REPO_NAME - Summary Title for Block 2]
- Bullet summarizing accomplishment with value/impact
- Bullet summarizing accomplishment with value/impact
```

One-block override:

```text
[REPO_NAME - Summary Title]
- Bullet summarizing accomplishment with value/impact
- Bullet summarizing accomplishment with value/impact
```

## Bullet Rules

- One bullet per commit.
- Highlight value: performance, user experience, maintainability, scalability, reliability, or compliance.
- Keep bullets direct and professional.
- Do not add explanations outside the code block.
