return {
  {
    'CopilotC-Nvim/CopilotChat.nvim',
    dependencies = {
      { 'github/copilot.vim' }, -- or zbirenbaum/copilot.lua
      { 'nvim-lua/plenary.nvim', branch = 'master' }, -- for curl, log and async functions
    },
    build = 'make tiktoken', -- Only on MacOS or Linux
    opts = {
      prompts = {
        MLCommitsPrompt = {
          prompt = 'Generate a precise, technical commit message that adheres to our standardized format. The format MUST strictly follow: [Category][Zach] followed by the change description.\n\nCategory MUST be one of these exact values (case-sensitive):\n- Feat: New feature implementation or enhancement\n- Fix: Bug resolution or error correction\n- Adjustment: Code refactoring, performance improvements, or structural changes\n- Chore: Maintenance tasks, dependency updates, or non-functional modifications\n\nYour response MUST conform to this exact pattern with no deviations:\n[Category][Zach] <concise_description>\n\nBased on the git diff I am staging, craft a commit message that:\n1. Uses the exact category taxonomy defined above\n2. Maintains description length under 50 characters (must be truncated if longer)\n3. Employs present tense, imperative mood verbs (e.g., "Add", "Fix", "Update", "Refactor")\n4. Focuses on the technical impact rather than implementation details\n5. References relevant system components (e.g., "user authentication", "database schema")\n\nConforming examples:\n[Feat][Zach] Implement JWT authentication middleware\n[Fix][Zach] Resolve race condition in async file uploads\n[Adjustment][Zach] Optimize database query indexing\n[Chore][Zach] Update React dependencies to v18.2.0\n\nNon-conforming examples (DO NOT USE):\n- Feature: Add user authentication - Missing proper category and name brackets\n- [Feature][Zach] Add user authentication - Invalid category name\n- [Feat] Add user authentication - Missing name bracket\n- [Feat][Zach]: Add user authentication - Prohibited colon after brackets\n- [Feat][Zach] Added user authentication - Incorrect verb tense (past)\n- [Feat][Zach] Implementing a new user authentication system that validates credentials - Exceeds character limit',

          system_prompt = 'You MUST generate a git commit message that EXACTLY follows this rigid format: [Category][Zach] Description. No deviations are permitted. Category must be one of these exact values (case-sensitive): Feat, Fix, Adjustment, or Chore. Both category and name must be independently wrapped in square brackets with no spaces between them. Your entire response must consist of a single line containing only the formatted commit message with no additional explanatory text, comments, prefixes, or formatting. Do not include quotation marks or any other decorative elements.',

          sticky = '#git:staged',
          mapping = '<leader>zq',
          description = 'Generate standardized commit message in [Category][Zach] format',
        },
        PersonalCommitPrompt = {
          prompt = 'Generate a concise and descriptive commit message following this format: category: change description\n\nWhere:\n- category must be one of: feat, chore, fix, or adjustment\n  - feat: New feature or functionality\n  - fix: Bug fix or error correction\n  - adjustment: Refactoring, optimization, or small improvements\n  - chore: Routine tasks, dependencies, configuration changes\n- change description: A brief, specific description of what changed, written in all lowercase letters\n\nBased on the code changes I\'m about to commit, craft a commit message that follows the format above.\nKeep the change description concise but informative.\nEnsure ALL text is in lowercase, including the category and description.\nUse present tense verbs (e.g., "add", "fix", "update", not "added", "fixed", "updated").\n\nExamples:\n- feat: add user authentication system\n- fix: resolve navbar display issue on mobile\n- adjustment: refactor database query functions\n- chore: update npm dependencies',
          system_prompt = 'You are an expert at creating clear and concise git commit messages that follow conventions.',
          sticky = '#git:staged',
          mapping = '<leader>zz',
          description = 'Generate a personal-style commit message in lowercase',
        },
      },
    },
    keys = {
      { '<Leader>zc', ':CopilotChatOpen<CR>', mode = 'n', desc = 'Chat with Copilot' },
      { '<Leader>ze', ':CopilotChatExplain<CR>', mode = 'v', desc = 'Explain Code' },
      { '<Leader>zr', ':CopilotChatReview<CR>', mode = 'v', desc = 'Review Code' },
      { '<Leader>zf', ':CopilotChatFix<CR>', mode = 'v', desc = 'Fix Code Issues' },
      { '<Leader>zo', ':CopilotChatOptimize<CR>', mode = 'v', desc = 'Optimize Code' },
      { '<Leader>zd', ':CopilotChatDocs<CR>', mode = 'v', desc = 'Generate Docs' },
      { '<Leader>zt', ':CopilotChatTests<CR>', mode = 'v', desc = 'Generate Tests' },
      { '<Leader>zm', ':CopilotChatCommit<CR>', mode = 'n', desc = 'Generate Commit Message' },
      { '<Leader>zs', ':CopilotChatCommit<CR>', mode = 'v', desc = 'Generate Commit for Selection' },
      { '<Leader>zq', ':CopilotChatPrompt MLCommitsPrompt<CR>', mode = 'n', desc = 'Zach-style Commit Message' },
      { '<Leader>zz', ':CopilotChatPrompt PersonalCommitPrompt<CR>', mode = 'n', desc = 'Personal-style Commit Message' },
    },
    config = function(_, opts)
      require('CopilotChat').setup(opts)
    end,
  },
}
