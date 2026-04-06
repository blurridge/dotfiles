# Adversarial Review

Perform a skeptical, adversarial code review that actively tries to find problems — not a friendly review that rubber-stamps changes. Think like a senior engineer who is looking for reasons to reject this PR.

## Determine what to review

If the user specifies a target (file path, commit range, or pasted code), review that. Otherwise:

1. Get the current branch: `git branch --show-current`
2. Find the merge base with the default branch (try `main` first, then `master`, then `origin/main`):
   ```
   git merge-base HEAD main 2>/dev/null || git merge-base HEAD master 2>/dev/null || git merge-base HEAD origin/main
   ```
3. Get all changes since that base:
   ```
   git diff <merge-base>...HEAD
   git log <merge-base>..HEAD --oneline
   ```
4. List changed files: `git diff --name-only <merge-base>...HEAD`

Read the actual file contents of changed files when the diff alone isn't enough to understand context (e.g., to see what surrounds a changed function).

## Understand the intent

Before criticizing, reconstruct what the developer was trying to accomplish from commit messages and changed file names. State this briefly — the adversarial analysis should attack the *implementation* against its own goals, not straw-man a different problem.

## Adversarial analysis

Work through these angles. Not every angle applies to every change — skip ones with nothing to say. But don't skip them lightly.

**Logic & correctness**
Off-by-one errors, wrong conditionals, incorrect assumptions about data shape or ordering, misuse of APIs, wrong comparisons (e.g., `==` vs `===`, value vs reference).

**Failure modes**
What inputs, states, or sequences of operations would break this? Null/undefined/empty inputs. Concurrent execution. Partial failures mid-operation. What happens when an external service is down? What if this is called before initialization is complete?

**Security**
Injection (SQL, shell, path traversal, template). Privilege escalation. Data exposure (logging sensitive fields, leaking stack traces to clients). Trust boundary violations (treating user-controlled data as trusted). Insecure defaults. Broken authentication or authorization logic.

**Error handling**
Are errors caught and surfaced correctly or swallowed silently? Do catch blocks actually handle the failure or just suppress it? Are error messages safe to expose? Does the code fail open or closed?

**Performance**
N+1 queries. Unbounded loops or recursion. Large in-memory accumulation. Blocking calls on hot paths. Missing indexes implied by query patterns. Repeated expensive computations that could be cached.

**Hidden complexity**
Tight coupling that will make this painful to change. Leaky abstractions. Behavior that depends on undocumented invariants. "Works now but breaks later" patterns (e.g., depends on insertion order of a dict, hardcoded limits). What breaks if a collaborator makes a reasonable nearby change?

**Test gaps**
What is conspicuously untested? What edge cases are missing? Are the existing tests actually testing the right thing, or are they testing implementation details that give false confidence?

## Output format

```
## Adversarial Review: <branch-name or target>

**Reviewed:** <N files changed, brief intent summary>

---

### Critical
<!-- Issues that could cause data loss, security breaches, or silent corruption -->

### High
<!-- Likely bugs or failure modes under realistic conditions -->

### Medium
<!-- Issues that are wrong but require specific conditions to trigger -->

### Low
<!-- Minor concerns, style issues with real consequences, or things worth watching -->

---

### Steelman
<!-- One honest paragraph on what this code does well. Adversarial ≠ purely negative. -->
```

For each finding, include:
- **File and line** (e.g., `src/auth/login.ts:47`)
- **What the problem is** — be specific, not vague
- **Why it matters** — the concrete failure scenario or exploit path, not just "this could be a problem"
- **Fix direction** — what needs to change (a sentence or two, not a full rewrite)

If a severity bucket has nothing, omit it — don't write "None found" as that reads as a rubber stamp.

## Tone

Be direct. Don't soften real issues with "minor nit" or "you might want to consider". If something is wrong, say it's wrong and explain why. The goal is to surface problems the developer might not have thought of, not to make them feel good about their code.

That said: be precise. Only flag things that are genuinely problematic. Invented issues or nitpicks about style preferences undermine trust in the review.
