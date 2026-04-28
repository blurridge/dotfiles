return {
  {
    'nvim-treesitter/nvim-treesitter',
    branch = 'main',
    lazy = false,
    build = ':TSUpdate',
    config = function()
      require('nvim-treesitter').install {
        'bash', 'c', 'diff', 'html', 'lua', 'luadoc', 'markdown', 'markdown_inline',
        'query', 'typescript', 'tsx', 'javascript', 'vim', 'vimdoc',
      }
      local available = nil
      vim.api.nvim_create_autocmd('FileType', {
        callback = function(ev)
          local lang = vim.treesitter.language.get_lang(ev.match)
          if not lang then return end
          available = available or require('nvim-treesitter').get_available()
          if not vim.tbl_contains(available, lang) then return end
          require('nvim-treesitter').install { lang }
          pcall(vim.treesitter.start)
        end,
      })
    end,
  },
}
-- vim: ts=2 sts=2 sw=2 et
