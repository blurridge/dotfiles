return {
  { -- Autoformat
    'stevearc/conform.nvim',
    event = { 'BufWritePre' },
    cmd = { 'ConformInfo' },
    keys = {
      {
        '<leader>f',
        function()
          require('conform').format { async = true, lsp_format = 'fallback' }
        end,
        mode = '',
        desc = '[F]ormat buffer',
      },
    },
    opts = {
      notify_on_error = false,
      -- Remove format_on_save
      formatters_by_ft = {
        lua = { 'stylua' },
        python = { 'black' }, -- Enable black for Python
        typescript = { 'prettier' }, -- Enable prettier for TypeScript
        javascript = { 'prettier' }, -- Enable prettier for JavaScript
        typescriptreact = { 'prettier' }, -- Enable prettier for React (TSX)
        javascriptreact = { 'prettier' }, -- Enable prettier for React (JSX)
      },
    },
  },
}
-- vim: ts=2 sts=2 sw=2 et
