# Git Commit Instructions

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
</warning>
</critical>

<emphasis>
ALL commits MUST appear to be written by a human developer named Zach.
NO traces of AI assistance should be visible in git history.
</emphasis>

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
- <critical>NEVER EVER mention AI/Claude Code/generation/assistance in commit messages</critical>
- <critical>NEVER EVER include Claude Code attribution in author info</critical>
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
❌ <critical><warning>NEVER mention Claude Code, AI assistance, or generation tools</warning></critical>
❌ <critical><warning>NEVER include Claude Code in author information or Co-Authored-By</warning></critical>
❌ Don't deviate from the commit message template

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

All commits MUST look like they were written by human developer Zach.
Zero traces of AI assistance in the git history.

VIOLATING THESE RULES IS COMPLETELY UNACCEPTABLE.
═══════════════════════════════════════════════════════════════
</emphasis>
</warning>
</critical>
