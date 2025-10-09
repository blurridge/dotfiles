# Git Commit Instructions for Claude Code

<critical>
<warning>
<emphasis>
ABSOLUTELY CRITICAL RULES - VIOLATING THESE IS UNACCEPTABLE:
</emphasis>
</warning>
</critical>

<critical>
<warning>
🚨 NEVER EVER mention "Claude Code" in commit messages
🚨 NEVER EVER mention "AI" in commit messages
🚨 NEVER EVER mention "AI assistance" in commit messages
🚨 NEVER EVER mention "generated" in commit messages
🚨 NEVER EVER mention "Claude" in commit author information
🚨 NEVER EVER include "Claude Code" in Co-Authored-By lines
🚨 NEVER EVER use generic messages like "update files" or "make changes"
</warning>
</critical>

<emphasis>
ALL commits MUST appear to be written by a human developer named Zach.
NO traces of AI assistance should be visible in git history.
EVERY commit must have a specific, meaningful description of what changed.
</emphasis>

## Commit Message Format

All commit messages MUST follow this exact template:

```
[Feat/Fix/Misc/Chore/Docs][Zach] <summary of change>
```

### Categories

- **Feat**: New features or functionality
- **Fix**: Bug fixes or corrections
- **Docs**: Documentation changes (README, comments, API docs, etc.)
- **Misc**: Miscellaneous changes (formatting, refactoring, etc.)
- **Chore**: Maintenance tasks (dependencies, configuration, build config, etc.)

### Requirements

- Create **separate commits for EACH file** that was changed or created
- Use the exact format above - no variations
- Write clear, concise summaries in present tense that describe the SPECIFIC change in THAT file
- <critical>NEVER EVER mention AI/Claude Code/generation/assistance in commit messages</critical>
- <critical>NEVER EVER include Claude Code attribution in author info</critical>
- Keep summaries under 72 characters when possible
- Each commit message must be UNIQUE and describe what changed in that specific file
- Never use generic messages - be specific about the change

## Granular Commit Strategy

### ONE FILE = ONE COMMIT (Default Approach)

For maximum traceability and clarity, create a separate commit for each file:

**Example sequence:**
```bash
git add src/services/payment.service.ts
git commit -m "[Feat][Zach] Add Stripe payment integration to payment service"

git add src/controllers/payment.controller.ts
git commit -m "[Feat][Zach] Create payment endpoint controller"

git add src/types/payment.types.ts
git commit -m "[Feat][Zach] Define payment transaction types"

git add src/tests/payment.test.ts
git commit -m "[Feat][Zach] Add unit tests for payment service"
```

### Logical Grouping (Only When Appropriate)

Only group files in a single commit when they represent ONE atomic, inseparable change:

**Acceptable grouping scenarios:**
- Moving/renaming files together (the old and new file)
- Tightly coupled files that cannot function independently (e.g., component + its styles)
- Import/export barrel files that ONLY re-export from a newly created module

**Example of acceptable grouping:**
```bash
git add src/components/PaymentForm.tsx src/components/PaymentForm.module.css
git commit -m "[Feat][Zach] Create payment form component with styles"
```

### NEVER Group These Separately

Always commit these in separate commits:
- Test files (separate from implementation)
- Documentation files (separate from code)
- Configuration files (separate from features)
- Type definitions (separate from implementation)
- API routes (separate from services/controllers)
- Database migrations (separate from application code)
- Auto-generated files (see special rules below)

## Process

1. Review all uncommitted changes with `git status`
2. Identify each file that was modified or created
3. For each file, create a separate commit with a specific message describing the change in that file
4. Ensure each commit is atomic and the codebase remains functional after each commit
5. Use meaningful summaries that explain WHY and WHAT changed in that specific file

## Examples by Category

### Feature Commits (Separate per File)
```bash
[Feat][Zach] Add user authentication middleware
[Feat][Zach] Create login endpoint in auth controller
[Feat][Zach] Add JWT token generation utility
[Feat][Zach] Define authentication types and interfaces
[Feat][Zach] Create user session management service
```

### Fix Commits (Separate per File)
```bash
[Fix][Zach] Resolve null pointer in payment processing service
[Fix][Zach] Correct validation logic in payment controller
[Fix][Zach] Fix type mismatch in payment types
```

### Documentation Commits (Separate per File)
```bash
[Docs][Zach] Update API documentation for payment endpoints
[Docs][Zach] Add inline documentation to payment service
[Docs][Zach] Create setup guide in README
```

### Miscellaneous Commits (Separate per File)
```bash
[Misc][Zach] Refactor transaction processing logic
[Misc][Zach] Extract validation helpers to utility file
[Misc][Zach] Reorganize import statements in auth module
```

### Chore Commits (Separate per File)
```bash
[Chore][Zach] Update TypeORM dependency in package.json
[Chore][Zach] Configure ESLint rules
[Chore][Zach] Add environment variables to .env.example
```

## Special Rules for Auto-Generated Files

### API Documentation and Client Library Updates

When changes include auto-generated files (`api-docs.json` and `packages/api-lib/src/api.ts`), these MUST be committed separately from your code changes:

1. **First**: Commit all your actual code changes (one commit per file)
   ```bash
   git add apps/web/src/utils/historyUtils.ts
   git commit -m "[Feat][Zach] Add REM1 and REM2 separation logic to history utils"
   
   git add apps/web/src/components/common/QueryHistoryContent.tsx
   git commit -m "[Feat][Zach] Update query history component to display separated data"
   ```

2. **Last**: Commit auto-generated files together with the standard message
   ```bash
   git add api-docs.json packages/api-lib/src/api.ts
   git commit -m "[Misc][Zach] Updated sources"
   ```

### Process for Auto-Generated Files
```bash
# Stage and commit your code changes one by one
git add <your-file-1>
git commit -m "[Category][Zach] Specific description of change"

git add <your-file-2>
git commit -m "[Category][Zach] Specific description of change"

# Finally, stage and commit auto-generated files together
git add api-docs.json packages/api-lib/src/api.ts
git commit -m "[Misc][Zach] Updated sources"
```

## What NOT to Do

❌ Don't combine multiple unrelated file changes in one commit
❌ Don't write vague summaries like "fix stuff", "updates", or "changes"
❌ Don't use the same commit message for different files
❌ <critical><warning>NEVER mention Claude Code, AI assistance, or generation tools</warning></critical>
❌ <critical><warning>NEVER include Claude Code in author information or Co-Authored-By</warning></critical>
❌ Don't deviate from the commit message template
❌ Don't commit test files together with implementation files
❌ Don't commit documentation together with code changes
❌ Don't use generic messages like "update files" or "make changes"

## Example Full Workflow

**Scenario**: You added a new payment feature with service, controller, types, and tests.

```bash
# Check what changed
git status

# Commit each file separately with specific messages
git add src/services/payment.service.ts
git commit -m "[Feat][Zach] Implement Stripe payment processing in service layer"

git add src/controllers/payment.controller.ts
git commit -m "[Feat][Zach] Add payment initiation endpoint to controller"

git add src/types/payment.types.ts
git commit -m "[Feat][Zach] Define payment transaction and response types"

git add src/middleware/payment-validation.middleware.ts
git commit -m "[Feat][Zach] Create payment request validation middleware"

git add src/tests/payment.service.test.ts
git commit -m "[Feat][Zach] Add unit tests for payment service"

git add src/tests/payment.controller.test.ts
git commit -m "[Feat][Zach] Add integration tests for payment endpoints"

git add README.md
git commit -m "[Docs][Zach] Document payment API endpoints in README"

# If auto-generated files were updated
git add api-docs.json packages/api-lib/src/api.ts
git commit -m "[Misc][Zach] Updated sources"
```

<critical>
<warning>
<emphasis>
═══════════════════════════════════════════════════════════════
FINAL REMINDER - THIS IS ABSOLUTELY NON-NEGOTIABLE:
═══════════════════════════════════════════════════════════════

🚨 NO "Claude Code" in commit messages
🚨 NO "AI" mentions anywhere in git history
🚨 NO "generated with" or similar phrases
🚨 NO Claude attribution in author fields
🚨 NO Co-Authored-By: Claude lines
🚨 ONE FILE = ONE COMMIT (with specific description)
🚨 NO generic messages - every commit must be specific

All commits MUST look like they were written by human developer Zach.
Zero traces of AI assistance in the git history.
Every file gets its own commit with a unique, specific message.

VIOLATING THESE RULES IS COMPLETELY UNACCEPTABLE.

═══════════════════════════════════════════════════════════════
</emphasis>
</warning>
</critical>
