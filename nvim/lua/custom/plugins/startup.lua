local version = vim.version()

local header = {
  '',
  '                  ⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⡀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀',
  '                  ⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⣯⠲⣄⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀',
  '                  ⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⣏⢧⠀⠛⣦⡀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀',
  '                  ⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⡗⡞⡆⠀⠈⠛⣦⡀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀',
  '                  ⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⣿⢡⢻⡄⠀⠀⠀⠙⢦⡀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⣀⡀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀',
  '                  ⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢻⢥⢊⢷⡈⠔⠠⠐⢆⣩⢢⡀⢀⣿⣦⡀⠀⣤⠀⠀⠀⢀⣀⣤⢴⡶⡻⣍⡟⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀',
  '                  ⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢸⢎⡱⢊⠗⣌⠣⡜⣨⠑⣎⠹⣲⠿⣯⠻⡾⣟⣧⣴⡞⣯⢻⡜⣧⢻⣵⠟⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀',
  '                  ⠀⠀⠀⣏⠲⣄⣀⠀⠀⠀⠀⠀⢸⡘⢆⡫⠜⣤⠳⣘⠤⣋⠴⠃⠇⠙⠄⠓⠑⠢⠒⠦⡙⢬⠫⡝⢾⣣⣯⣤⢤⣤⣴⠆⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀',
  '                  ⠸⣿⡻⢟⠧⣠⠘⠻⢄⡀⠀⠀⠀⡿⡘⢤⡛⣄⡇⠃⢀⠀⠀⡀⠀⠀⠄⡀⢀⠃⠘⠀⠣⡘⢇⠻⡄⢇⡛⠿⣼⣼⠃⣀⣀⠀⣀⡀⣀⣀⣀⣀⣀⣀⣀⣀⣀⣀⣀⣀⠀⠀',
  '                  ⠀⢈⣳⢩⠒⡭⢲⡀⠀⠈⠓⢤⣀⡷⣩⡶⡛⣥⠀⠀⠀⠀⢀⠀⠀⠁⢂⠐⠠⠀⠀⠌⠐⠈⡌⠓⡜⢣⢍⠳⣌⠯⡱⣄⠈⠉⠁⠉⠁⢈⠀⠁⢀⠀⢀⠀⣄⣤⠶⣻⠟⠁',
  '                  ⠀⠛⠲⢧⡹⣐⢣⠹⢦⡀⢦⡘⣼⡿⣋⠴⢛⡁⠀⠠⠁⢀⠠⠀⠌⠀⠀⠠⠁⠀⠂⢀⠁⠂⢌⠱⣈⠇⣎⠳⣌⠳⡱⡌⠖⡄⠂⠌⡐⠠⢀⣂⣤⠖⡞⣹⢣⡾⠋⠀⠀⠀',
  '                  ⠀⠀⠀⠈⢳⡱⣊⢕⢪⡙⢮⠳⣉⠖⣡⡾⠋⠀⢰⡀⠀⠠⠀⠀⠀⢀⠀⠁⠠⠐⠀⢂⠈⡐⡈⠔⣌⠚⣤⠛⣌⢳⠱⡸⢱⢈⡡⠤⢖⡻⢍⠳⣌⠳⣜⠗⠋⠀⠀⠀⠀⠀',
  '                  ⠀⠀⠀⠀⠈⢳⡱⣊⢦⡙⣌⢣⠕⣪⠑⢦⡑⢲⡬⣇⠠⠐⠀⠁⢀⠀⡀⠌⠐⡀⢁⠂⢄⢠⡑⢎⡔⣫⢔⡫⣜⡡⢇⡳⡱⢪⢕⡋⢦⢣⡙⢖⣬⠟⠁⠀⠀⠀⠀⠀⠀⠀',
  '                  ⠀⠀⠀⠀⠀⠀⢻⡜⣶⣋⢦⠓⡎⢥⠛⡤⢭⠋⠀⢸⡄⠀⠌⡐⢀⠂⠄⡈⠄⡐⠠⢌⢢⠦⣙⢦⡹⢔⠮⡱⢦⠹⡜⢲⠍⣇⠞⣌⢣⢲⡽⠋⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀',
  '                  ⠀⠀⠀⠀⠀⠀⠀⣹⠳⡜⢦⠛⣜⢢⡛⢬⡏⡀⠀⠀⢿⣆⠰⣈⢦⣐⠠⣐⠢⣜⡱⢎⡣⢞⡡⢖⡍⣎⣳⡽⣌⠳⣉⢧⢚⣼⡚⣴⠟⠉⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀',
  '                  ⠀⠀⠀⠀⠀⠀⢠⢇⡻⢌⠧⡛⣼⡧⢜⡡⣇⠁⢀⠀⢾⣏⢧⡙⢦⣃⠯⣔⢫⡔⠣⣜⠱⣣⣙⡦⠟⠉⣷⡱⣌⢣⢣⢎⡣⢞⡟⠁⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀',
  '                  ⠀⠀⠀⠀⠀⠀⡼⢠⠙⣎⢳⡹⢴⠻⣎⠵⣙⠦⣅⡓⠀⠸⣶⡙⢦⢃⡞⢬⠲⣌⠓⣬⡷⠛⠉⠀⠠⢀⡷⡳⣌⠇⡞⣰⠹⣌⣯⢛⡳⣒⢖⡲⣒⠖⣦⠤⠤⢀⡀⠀⠀⠀',
  '                  ⠀⠀⠀⠀⠀⠀⡏⠤⡙⡌⢧⡹⢾⠀⠈⠷⣎⡹⡜⣭⢛⠿⡽⡜⣣⢣⠞⣡⢳⡼⠛⠹⠃⠀⠀⠠⢡⡼⢳⡱⢪⡙⣖⣡⠓⣼⢧⢫⠴⣩⠎⡵⣸⢘⡴⢋⡽⠻⠤⣀⠀⠀',
  '                  ⠀⠀⠀⠀⠀⠀⣟⠰⢠⡙⢮⢵⣻⡄⠀⢠⠋⠳⢽⣰⢋⢮⡱⢎⡵⢪⡙⣖⢫⠗⣤⣀⣀⣀⣄⣶⠫⡝⣣⡕⣣⠝⡴⣊⡝⢦⣋⢎⢧⡑⢮⠱⢎⡱⢎⡵⢊⡟⠛⠉⠀⠀',
  '                  ⠀⠀⠀⠀⠀⠀⣏⠲⣁⢾⣩⣞⠶⣷⡀⡎⠀⠀⠀⠉⡛⠲⠽⣎⣜⢧⣙⢦⣋⠾⡰⢭⡹⣙⢞⡰⢫⣴⣟⡱⢣⢏⠶⡱⢎⡳⡜⣎⠶⣙⢦⢛⣬⡳⠗⠛⠳⠇⠀⠀⠀⠀',
  '                  ⠀⠀⠀⠀⠀⠀⣯⢳⡰⢊⡷⣯⢿⣹⣟⣧⠀⠀⠀⢠⠃⠀⠀⠀⠈⠉⠙⠲⠛⠚⠽⠷⠓⡟⠚⠋⣩⡟⣴⢫⡝⣮⢳⣝⣻⡵⣹⣬⣳⠽⠚⠋⠁⠀⠀⠀⠀⠀⠀⠀⠀⠀',
  '                  ⠀⠀⠀⠀⠀⣴⣿⡧⡽⣭⣻⣽⣯⢷⣻⣞⣷⣦⡀⡼⠀⠀⠀⠀⠀⠀⢀⡇⠀⠀⠀⠀⢰⠁⢀⣼⢧⣻⣜⣧⢿⣼⣳⢾⠟⠛⠉⠁⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀',
  '                  ⠀⠀⠀⠀⣸⢿⣿⣷⡝⣾⣷⣿⣿⣿⣿⣽⣾⣟⣿⣷⣦⣤⣀⡀⠀⠀⢸⠀⠀⠀⠀⢀⣮⣶⣿⣽⣯⣷⢿⣞⣿⢾⣽⠏⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀',
  '                  ⠀⠀⠀⠀⣿⡓⣞⡿⣿⣳⣿⡿⣿⣾⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣶⣶⣿⣿⣿⡿⣟⣾⣯⣷⣿⣿⣯⣿⣿⠏⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀',
  '                  ⠀⠀⠀⠀⣷⠙⣦⢻⣽⣿⢻⣽⣿⣿⡟⣿⣯⣿⣿⣾⣿⣿⢻⣽⣿⣿⣷⣿⣯⣿⣿⣽⣿⣿⢻⣽⣿⣽⣾⣿⣿⠋⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀',
  '                  ⠀⠀⠀⠀⠸⣷⣊⠶⣭⢻⣿⣿⣯⣷⣿⣿⣿⡿⣿⣿⢿⣻⣿⣿⣿⣿⣿⣻⣿⢿⡽⢏⡳⢬⢣⣓⢮⡻⢿⣿⠏⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀',
  '                  ⠀⠀⠀⠀⠀⠙⢿⣾⣼⣿⣳⣿⣿⣯⡷⣿⡷⣿⣿⢿⣿⣿⣿⢿⣿⣻⣿⣿⢯⡛⣜⢣⡝⣎⢳⢬⠳⣝⢯⡿⡆⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀',
  '                  ⠀⠀⠀⠀⠀⠀⠀⠈⢻⣷⣿⣷⣿⣿⠛⢷⣻⡽⣯⢿⣿⡾⣿⡿⣟⣿⡿⣞⣯⢳⣌⢳⡜⡬⢓⢮⣹⡞⡿⣜⡷⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀',
  '                  ⠀⠀⠀⠀⠀⠀⠀⠀⠀⠙⠟⢿⡏⠙⠀⠀⠈⠙⠿⢿⣾⣟⣿⣽⣿⣻⣽⡻⣜⢯⣲⢯⡛⣴⢻⣋⠷⣩⢓⡎⡗⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀',
  '                  ⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠻⣿⣿⢿⣿⠏⠉⠙⢯⢎⡳⢎⣵⣏⣶⣯⢒⠥⣋⣼⠃⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀',
  '                  ⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠈⠙⠿⠏⠀⠀⠀⠈⢧⡝⣾⣿⣿⣿⣿⣾⣿⡼⠃⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀',
  '                  ⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠈⢿⣿⣿⣳⡿⣞⡿⠊⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀',
  '                  ⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠙⠛⠛⠛⠉⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀',
  '',
  '  NEOVIM v' .. version.major .. '.' .. version.minor,
  '',
}

local center = {
  {
    desc = 'Find File ',
    key = 'f',
    icon = ' ',
    action = 'Telescope find_files',
    group = '@markup.heading.1.markdown',
  },
  {
    desc = 'New File ',
    key = 'n',
    icon = ' ',
    action = 'enew',
    group = '@markup.heading.3.markdown',
  },
  {
    desc = 'Reload Session ',
    key = 'r',
    icon = ' ',
    action = 'SessionLoad',
    group = '@markup.heading.4.markdown',
  },
  {
    desc = 'Exit ',
    key = 'q',
    icon = ' ',
    action = 'exit',
    group = '@markup.heading.6.markdown',
  },
}

local footer = {
  '',
  '    ✨ Excellence as a goal is nothing, but excellence as a habit is everything. ✨',
  '',
}

vim.api.nvim_create_autocmd('Filetype', {
  pattern = 'dashboard',
  group = vim.api.nvim_create_augroup('Dashboard_au', { clear = true }),
  callback = function()
    vim.cmd [[
            setlocal buftype=nofile
            setlocal nonumber norelativenumber nocursorline noruler fillchars=eob:\ 
            nnoremap <buffer> <F2> :h news.txt<CR> 
        ]]
  end,
})

return {
  'nvimdev/dashboard-nvim',
  opts = {
    theme = 'hyper',
    config = {
      header = header,
      shortcut = center,
      footer = footer,
      packages = { enable = false },
      project = {
        enable = true,
        limit = 3,  -- Limit recent projects to 5
      },
      mru = {
        limit = 5,  -- Limit MRU (Most Recently Used) files to 5
      },
    },
  },
}
