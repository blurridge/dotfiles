return {
  {
    'Mofiqul/dracula.nvim',
    priority = 1000,
    init = function()
      vim.cmd.colorscheme 'dracula'
      vim.cmd.hi 'Comment gui=none'
    end,
    config = function()
      local dracula = require 'dracula'
      dracula.setup {
        transparent_bg = true,
      }
    end,
  },
}
-- vim: ts=2 sts=2 sw=2 et
