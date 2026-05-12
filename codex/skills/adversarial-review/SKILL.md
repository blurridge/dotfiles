---
name: adversarial-review
description: Manual invocation only. Use when explicitly invoked as $adversarial-review to perform a skeptical adversarial code review of a target or the current branch.
---

# Adversarial Review

Perform a skeptical, adversarial code review that actively tries to find problems. Think like a senior engineer looking for reasons to reject the change.

## Determine What To Review

If the user specifies a target such as a file path, commit range, or pasted code, review that. Otherwise:

1. Get the current branch with `git branch --show-current`.
2. Find the merge base with the default branch:

```bash
git merge-base HEAD main 2>/dev/null || git merge-base HEAD master 2>/dev/null || git merge-base HEAD origin/main
```

3. Get changes since that base:

```bash
git diff <merge-base>...HEAD
git log <merge-base>..HEAD --oneline
git diff --name-only <merge-base>...HEAD
```

Read actual file contents when the diff alone does not provide enough context.

## Understand The Intent

Before criticizing, reconstruct what the developer was trying to accomplish from commit messages and changed file names. State this briefly. Attack the implementation against its own goals, not a straw-man requirement.

## Review Angles

Cover applicable issues from these areas:

- Logic and correctness: off-by-one errors, wrong conditionals, incorrect assumptions, API misuse, wrong comparisons.
- Failure modes: null, undefined, empty inputs, concurrency, partial failures, uninitialized state, external service outages.
- Security: injection, privilege escalation, data exposure, trust boundary violations, insecure defaults, auth bugs.
- Error handling: swallowed errors, unsafe messages, fail-open behavior, catch blocks that do not handle failures.
- Performance: N+1 queries, unbounded loops, large memory accumulation, blocking hot paths, missing indexes, repeated expensive work.
- Hidden complexity: tight coupling, leaky abstractions, undocumented invariants, fragile assumptions.
- Test gaps: missing edge cases, tests that assert implementation details, false confidence.

## Output Format

```markdown
## Adversarial Review: <branch-name or target>

**Reviewed:** <N files changed, brief intent summary>

---

### Critical
### High
### Medium
### Low

---

### Steelman
```

Omit empty severity sections. For each finding, include:

- File and line, such as `src/auth/login.ts:47`.
- What the problem is.
- Why it matters, with a concrete failure scenario or exploit path.
- Fix direction, in one or two sentences.

## Tone

Be direct and precise. Only flag genuinely problematic issues. Do not invent risks or nitpick preferences.
