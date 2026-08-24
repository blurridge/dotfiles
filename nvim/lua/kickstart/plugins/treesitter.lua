return {
  {
    'nvim-treesitter/nvim-treesitter',
    branch = 'main',
    lazy = false,
    build = ':TSUpdate',
    config = function()
      require('nvim-treesitter').install {
        'bash', 'c', 'diff', 'html', 'lua', 'luadoc', 'markdown', 'markdown_inline', 'python',
        'query', 'typescript', 'tsx', 'javascript', 'vim', 'vimdoc',
      }
      vim.api.nvim_create_autocmd('FileType', {
        callback = function(ev)
          pcall(vim.treesitter.start, ev.buf)
        end,
      })
    end,
  },
}
-- vim: ts=2 sts=2 sw=2 et
