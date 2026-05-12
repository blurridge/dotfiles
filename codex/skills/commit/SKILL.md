---
name: commit
description: Manual invocation only. Use when explicitly invoked as $commit to create dependency-aware git commits using Zach's strict one-line commit format.
---

# Git Commit Guidelines

## Critical Rules

- Never mention Codex, OpenAI, Claude, Anthropic, AI, assistance, generated, or automation in commits or author info.
- Never add attribution trailers or generated-by lines.
- Never use generic messages like "update files" or "make changes".
- All commits must appear written by human developer Zach.
- Every commit needs a specific, meaningful description.
- Commit messages must be exactly one line, with no body.

## Forbidden Attribution

Do not add any of these, or anything similar:

- `Generated with ...`
- `Created with ...`
- `Co-Authored-By: Claude <noreply@anthropic.com>`
- `Co-Authored-By: Codex`
- `Co-Authored-By: OpenAI`
- Any AI/tool attribution emoji, link, or trailer

The commit message must be a single line with nothing before it and nothing after it.

## Commit Format

```text
[Feat/Fix/Misc/Chore/Docs][Zach] <specific change summary>
```

Categories:

- `Feat`: New features
- `Fix`: Bug fixes
- `Docs`: Documentation
- `Misc`: Formatting, refactoring
- `Chore`: Dependencies, config

Examples:

```text
[Feat][Zach] Add payment processing service with Stripe integration
[Fix][Zach] Resolve null pointer exception in user validation
[Docs][Zach] Update API documentation for payment endpoints
```

## Grouping Strategy

Dependency-based grouping rules:

1. Single-use constant, enum, type, or util: commit with its consumer.
2. Multi-use dependency where all consumers only implement it: commit all together.
3. Multi-use dependency where consumers have mixed changes: commit dependency separately first.
4. Independent files: commit alone.

Always separate:

- Tests from implementation.
- Docs from code.
- Config files.
- Database migrations.
- Shared utilities used by multiple files.
- Auto-generated files, committed last with `[Misc][Zach] Updated sources`.

## Workflow

1. Inspect the working tree with `git status --short`.
2. Review diffs with `git diff` and, when needed, read surrounding file context.
3. Group changed files according to the rules above.
4. Stage each group explicitly with `git add <paths>`.
5. Commit each group with `git commit -m "<one-line message>"`.
6. Do not use broad staging unless every changed file belongs in the same commit.

## Common Mistakes

- Committing shared dependencies with unrelated consumers.
- Committing tests with implementation.
- Using vague messages like "fix stuff", "updates", or "changes".
- Mentioning AI, Claude, Codex, OpenAI, or generated tooling.
- Reusing the same message for distinct commits.
