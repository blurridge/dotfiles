return {
  {
    'akinsho/bufferline.nvim',
    dependencies = 'nvim-tree/nvim-web-devicons',
    config = function()
      require('bufferline').setup {
        options = {
          numbers = 'none',
          diagnostics = 'nvim_lsp',
          show_buffer_icons = true,
          show_buffer_close_icons = false,
          show_close_icon = false,
          separator_style = 'none', -- Set to 'slant' or 'none'
          always_show_bufferline = true,
          offsets = {
            {
              filetype = 'NvimTree',
              text = 'File Explorer',
              highlight = 'Directory',
              text_align = 'left',
            },
          },
        },
        highlights = {
          fill = { bg = "NONE" }, -- Let terminal background show through
          background = { bg = "#282a36" },
          buffer_selected = { fg = "#f8f8f2", bg = "#282a36", bold = true },
          buffer_visible = { fg = "#6272a4", bg = "#282a36" },
          indicator_selected = { fg = "#ff79c6", bg = "#282a36" },
        },
      }
      vim.api.nvim_set_keymap('n', '<Tab>', ':BufferLineCycleNext<CR>', { noremap = true, silent = true })
      vim.api.nvim_set_keymap('n', '<S-Tab>', ':BufferLineCyclePrev<CR>', { noremap = true, silent = true })
      vim.api.nvim_set_keymap('n', '<leader>w', ':bdelete<CR>', { noremap = true, silent = true })
    end,
  },
}
