return {
  {
    'akinsho/bufferline.nvim',
    dependencies = 'nvim-tree/nvim-web-devicons',
    config = function()
      require('bufferline').setup {
        options = {
          numbers = 'none', -- Show buffer numbers
          diagnostics = 'nvim_lsp', -- Integrate LSP diagnostics (optional)
          show_buffer_icons = true, -- Enable file type icons
          show_buffer_close_icons = false, -- Option to disable close icons on tabs
          show_close_icon = false,
          separator_style = 'slant', -- Style for separators (you can choose "thin", "slant", etc.)
          always_show_bufferline = true, -- Always show bufferline
          offsets = {
            {
              filetype = 'NvimTree',
              text = 'File Explorer',
              highlight = 'Directory',
              text_align = 'left',
            },
          },
        },
      }
      vim.api.nvim_set_keymap('n', '<Tab>', ':BufferLineCycleNext<CR>', { noremap = true, silent = true })
      vim.api.nvim_set_keymap('n', '<S-Tab>', ':BufferLineCyclePrev<CR>', { noremap = true, silent = true })
      vim.api.nvim_set_keymap('n', '<leader>w', ':bdelete<CR>', { noremap = true, silent = true })
    end,
  },
}

