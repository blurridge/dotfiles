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
      vim.api.nvim_create_autocmd('FileType', {
        callback = function(ev)
          local lang = vim.treesitter.language.get_lang(ev.match) or ev.match
          require('nvim-treesitter.install').install { lang }
          pcall(vim.treesitter.start)
        end,
      })
    end,
  },
}
-- vim: ts=2 sts=2 sw=2 et
