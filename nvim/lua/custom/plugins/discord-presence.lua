return {
  {
    'vyfor/cord.nvim',
    config = function()
      local icon = require('cord.api.icon').get
      require('cord').setup {
        editor = {
          tooltip = 'Struggling with vim help me',
        },
        display = {
          theme = 'catppuccin',
          flavor = 'accent',
          swap_fields = false,
          swap_icons = false,
        },
        timestamp = {
          enabled = true,
          reset_on_idle = false,
          reset_on_change = false,
        },
        idle = {
          enabled = true,
          timeout = 300000,
          show_status = true,
        },
        assets = {
          ['.service.ts'] = { icon = icon('typescript'), tooltip = 'TypeScript' },
          ['.module.ts'] = { icon = icon('typescript'), tooltip = 'TypeScript' },
          ['.guard.ts'] = { icon = icon('typescript'), tooltip = 'TypeScript' },
          ['.interceptor.ts'] = { icon = icon('typescript'), tooltip = 'TypeScript' },
        },
      }
    end,
  },
}
