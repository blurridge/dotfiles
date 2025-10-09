# Git Commit Guidelines

<critical_rules>
NEVER mention: Claude Code, AI, assistance, generated, or Claude in commits/author info
NO generic messages like "update files" or "make changes"
All commits must appear written by human developer Zach
Every commit needs specific, meaningful description
</critical_rules>

<commit_format>
[Feat/Fix/Misc/Chore/Docs][Zach] <specific change summary>

Categories:
- Feat: New features
- Fix: Bug fixes
- Docs: Documentation
- Misc: Formatting, refactoring
- Chore: Dependencies, config
</commit_format>

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
git commit -m "[Feat][Zach] Add payment processing service with status constants"

Scenario 2: Multiple Consumers (Pure Implementation)
# All 3 files ONLY add UserRole usage, no other changes
git add src/enums/user.enums.ts src/guards/role.guard.ts src/middleware/auth.middleware.ts src/services/user.service.ts
git commit -m "[Feat][Zach] Implement user role enum across guards, middleware, and service"

Scenario 3: Multiple Consumers (Mixed Changes)
# service.ts has UserRole + other changes
git add src/enums/user.enums.ts
git commit -m "[Feat][Zach] Define user role enum"

git add src/guards/role.guard.ts src/middleware/auth.middleware.ts
git commit -m "[Feat][Zach] Implement user role enum in guards and middleware"

git add src/services/user.service.ts
git commit -m "[Feat][Zach] Add user role enum support and bulk update feature"
</examples>

<workflow_example>
# Shared type (used by 3 files) - commit first
git add src/types/payment.types.ts
git commit -m "[Feat][Zach] Define payment data transfer types"

# Service + its exclusive constants
git add src/services/payment.service.ts src/constants/payment-errors.constants.ts
git commit -m "[Feat][Zach] Implement payment processing service with error messages"

# Controller (uses shared dependencies)
git add src/controllers/payment.controller.ts
git commit -m "[Feat][Zach] Create payment endpoint controller"

# Tests always separate
git add src/tests/payment.service.test.ts
git commit -m "[Feat][Zach] Add unit tests for payment service"

# Auto-generated files last
git add api-docs.json packages/api-lib/src/api.ts
git commit -m "[Misc][Zach] Updated sources"
</workflow_example>

<common_mistakes>
- Committing shared dependencies with multiple consumers together
- Committing tests with implementation
- Vague messages: "fix stuff", "updates", "changes"
- Mentioning AI/Claude/generation tools
- Using same message for different commits
- Generic messages like "update files"
</common_mistakes>

<critical_rules>
NEVER mention: Claude Code, AI, assistance, generated, or Claude in commits/author info
NO generic messages like "update files" or "make changes"
All commits must appear written by human developer Zach
Every commit needs specific, meaningful description
</critical_rules>
