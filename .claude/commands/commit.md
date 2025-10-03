# Git Commit Instructions

## Commit Message Format
All commit messages MUST follow this exact template:

[Feat/Fix/Misc/Chore/Docs][Zach] <summary of change>

### Categories
- **Feat**: New features or functionality
- **Fix**: Bug fixes or corrections
- **Docs**: Documentation changes (README, comments, API docs, etc.)
- **Misc**: Miscellaneous changes (formatting, refactoring, etc.)
- **Chore**: Maintenance tasks (dependencies, configuration, etc.)

### Requirements
- Create **granular commits** - one logical change per commit
- Use the exact format above - no variations
- Write clear, concise summaries in present tense
- Do NOT mention AI/Claude Code generation in commit messages
- Keep summaries under 72 characters when possible

### Examples
[Feat][Zach] Add user authentication middleware
[Fix][Zach] Resolve null pointer in payment processing
[Docs][Zach] Update API documentation for payment endpoints
[Misc][Zach] Refactor transaction processing logic
[Chore][Zach] Upgrade TypeORM to version 0.3.20

## Process
1. Review all uncommitted changes
2. Group related changes logically
3. Create separate commits for each distinct change
4. Ensure each commit is atomic and functional
5. Use meaningful summaries that explain WHY, not just WHAT

## Special Rules for Auto-Generated Files

### API Documentation and Client Library Updates
When changes include auto-generated files (`api-docs.json` and `packages/api-lib/src/api.ts`), these MUST be committed separately:

1. **First commit**: Your actual code changes (without api-docs.json and api.ts)
   - Example: `[Feat][Zach] Separate REM1 and REM2 ALL data in query history details`

2. **Second commit**: Auto-generated files only
   - Always use: `[Chore][Zach] Updated sources`

### Process
```bash
# Stage only your code changes (exclude auto-generated files)
git add apps/web/src/utils/historyUtils.ts apps/web/src/components/common/QueryHistoryContent.tsx
git commit -m "[Feat][Zach] Your feature description"

# Then stage and commit auto-generated files
git add api-docs.json packages/api-lib/src/api.ts
git commit -m "[Misc][Zach] Updated sources"

## What NOT to Do
❌ Don't combine unrelated changes in one commit
❌ Don't write vague summaries like "fix stuff" or "updates"
❌ Don't mention Claude Code, AI assistance, or generation tools
❌ Don't deviate from the commit message template
