# Git Commit Guidelines

<critical_rules>
NEVER mention: Claude Code, AI, assistance, generated, or Claude in commits/author info
NO generic messages like "update files" or "make changes"
All commits must appear written by human developer Zach
Every commit needs specific, meaningful description
NEVER add attribution lines like "🤖 Generated with" or "Co-Authored-By: Claude"
Commit messages must be EXACTLY ONE LINE - no additional text
</critical_rules>

<forbidden_attribution>
❌ NEVER ADD THESE LINES TO ANY COMMIT MESSAGE:

🤖 Generated with [Claude Code](https://claude.com/claude-code)
Co-Authored-By: Claude <noreply@anthropic.com>

❌ DO NOT ADD:
- Any emoji attribution (🤖, 🔧, etc.)
- Any "Generated with" or "Created with" lines
- Any "Co-Authored-By: Claude" or similar attribution
- Any links to Claude Code, Anthropic, or AI tools
- Any mention of AI assistance in any form

YOUR COMMIT MESSAGE MUST BE A SINGLE LINE WITH NO ADDITIONAL TEXT AFTER IT.
</forbidden_attribution>

<commit_format>
[Feat/Fix/Misc/Chore/Docs][Zach] <specific change summary>

Categories:
- Feat: New features
- Fix: Bug fixes
- Docs: Documentation
- Misc: Formatting, refactoring
- Chore: Dependencies, config
</commit_format>

<correct_commit_format>
✅ CORRECT FORMAT (single line only, nothing else):

[Feat][Zach] Add payment processing service with Stripe integration

✅ CORRECT:

[Fix][Zach] Resolve null pointer exception in user validation

✅ CORRECT:

[Docs][Zach] Update API documentation for payment endpoints


❌ WRONG (has forbidden attribution lines):

[Feat][Zach] Add payment processing service

🤖 Generated with [Claude Code](https://claude.com/claude-code)

Co-Authored-By: Claude <noreply@anthropic.com>

❌ WRONG (multi-line with extra text):

[Feat][Zach] Add payment processing service

Added Stripe integration and error handling


THE COMMIT MESSAGE IS EXACTLY ONE LINE. NOTHING BEFORE IT. NOTHING AFTER IT.
</correct_commit_format>

<commit_scope>
Determine the scope from the conversation before staging anything. Do not ask the user to select files or confirm before committing; stage and commit the determined scope immediately.

- In a fresh conversation with no prior implementation context, commit every working-tree change: staged, unstaged, untracked, renamed, and deleted files. Use `git add -A`.
- In an existing conversation, commit only files created, modified, renamed, or deleted by the agent during that conversation. Do not include pre-existing or user-made changes, even if they are already staged.
- If a file's origin cannot be determined reliably in an existing conversation, exclude it rather than asking the user whether to include it.
- For every group, use `git commit --only -- <paths>` so unrelated staged changes are excluded. In a fresh conversation, first stage the complete working tree with `git add -A`.
</commit_scope>

<grouping_strategy>
Dependency-Based Grouping Rules:

1. Single-use constant/enum/type/util → Commit WITH its consumer
2. Multi-use dependency, ALL consumers only implement it → Commit ALL together
3. Multi-use dependency, consumers have mixed changes → Commit dependency separately first
4. Independent files → Commit alone

Always Separate:
- Tests (from implementation)
- Docs (from code)
- Config files
- Database migrations
- Shared utilities used by multiple files
- Auto-generated files (commit last with "[Misc][Zach] Updated sources")
</grouping_strategy>

<examples>
Scenario 1: Single Consumer
# payment.service.ts imports PAYMENT_STATUS (only user)
# payment.constants.ts defines PAYMENT_STATUS
git add src/services/payment.service.ts src/constants/payment.constants.ts
git commit --only -m "[Feat][Zach] Add payment processing service with status constants" -- src/services/payment.service.ts src/constants/payment.constants.ts

Scenario 2: Multiple Consumers (Pure Implementation)
# All 3 files ONLY add UserRole usage, no other changes
git add src/enums/user.enums.ts src/guards/role.guard.ts src/middleware/auth.middleware.ts src/services/user.service.ts
git commit --only -m "[Feat][Zach] Implement user role enum across guards, middleware, and service" -- src/enums/user.enums.ts src/guards/role.guard.ts src/middleware/auth.middleware.ts src/services/user.service.ts

Scenario 3: Multiple Consumers (Mixed Changes)
# service.ts has UserRole + other changes
git add src/enums/user.enums.ts
git commit --only -m "[Feat][Zach] Define user role enum" -- src/enums/user.enums.ts

git add src/guards/role.guard.ts src/middleware/auth.middleware.ts
git commit --only -m "[Feat][Zach] Implement user role enum in guards and middleware" -- src/guards/role.guard.ts src/middleware/auth.middleware.ts

git add src/services/user.service.ts
git commit --only -m "[Feat][Zach] Add user role enum support and bulk update feature" -- src/services/user.service.ts
</examples>

<workflow_example>
# Shared type (used by 3 files) - commit first
git add src/types/payment.types.ts
git commit --only -m "[Feat][Zach] Define payment data transfer types" -- src/types/payment.types.ts

# Service + its exclusive constants
git add src/services/payment.service.ts src/constants/payment-errors.constants.ts
git commit --only -m "[Feat][Zach] Implement payment processing service with error messages" -- src/services/payment.service.ts src/constants/payment-errors.constants.ts

# Controller (uses shared dependencies)
git add src/controllers/payment.controller.ts
git commit --only -m "[Feat][Zach] Create payment endpoint controller" -- src/controllers/payment.controller.ts

# Tests always separate
git add src/tests/payment.service.test.ts
git commit --only -m "[Feat][Zach] Add unit tests for payment service" -- src/tests/payment.service.test.ts

# Auto-generated files last
git add api-docs.json packages/api-lib/src/api.ts
git commit --only -m "[Misc][Zach] Updated sources" -- api-docs.json packages/api-lib/src/api.ts
</workflow_example>

<common_mistakes>
- Committing shared dependencies with multiple consumers together
- Committing tests with implementation
- Asking the user to select files instead of determining scope from the conversation
- Including pre-existing or user-made files in an existing conversation
- Vague messages: "fix stuff", "updates", "changes"
- Mentioning AI/Claude/generation tools
- Using same message for different commits
- Generic messages like "update files"
- Asking for confirmation before staging or committing
- Running tests, typechecking, linting, builds, or other pre-commit validation commands. Assume the user has already completed validation; Git hooks enforce any required checks.
</common_mistakes>
