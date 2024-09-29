return {
  {
    'nvim-tree/nvim-tree.lua',
    requires = {
      'nvim-tree/nvim-web-devicons', -- optional, for file icons
    },
    config = function()
      require('nvim-tree').setup {
        -- General options
        disable_netrw = true, -- Disables netrw completely
        hijack_netrw = true, -- Prevents netrw from managing the directories
        sync_root_with_cwd = true, -- Update the tree when changing directories
        diagnostics = {
          enable = true, -- Show LSP diagnostics in the tree
          icons = {
            hint = '',
            info = '',
            warning = '',
            error = '',
          },
        },
        git = {
          enable = true, -- Enable git integration
          ignore = false, -- Show ignored files
          timeout = 500, -- Git timeout in ms
        },
        view = {
          width = 30, -- Tree window width
          side = 'left', -- Tree window position
        },
        renderer = {
          highlight_opened_files = 'all', -- Highlight opened files
          root_folder_label = false, -- Don't hide the root folder label
          icons = {
            glyphs = {
              default = '',
              symlink = '',
              git = {
                unstaged = '',
                staged = 'S',
                unmerged = '',
                renamed = '➜',
                deleted = '',
                untracked = 'U',
              },
              folder = {
                default = '',
                open = '',
                empty = '',
                empty_open = '',
                symlink = '',
              },
            },
          },
        },
        actions = {
          open_file = {
            quit_on_open = true, -- Closes the tree when a file is opened
          },
        },
      }
      vim.api.nvim_set_keymap('n', '<C-n>', ':NvimTreeToggle<CR>', { noremap = true, silent = true })
    end,
  },
}
