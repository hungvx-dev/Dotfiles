local neotree = require('plugins.neotree')
local window_picker = require('plugins.window-picker')

vim.pack.add({
  'https://github.com/nvim-lua/plenary.nvim',
  'https://github.com/MunifTanjim/nui.nvim',
  'https://github.com/echasnovski/mini.icons',
  { src = 'https://github.com/s1n7ax/nvim-window-picker', version = vim.version.range('2.*') },
  { src = 'https://github.com/nvim-neo-tree/neo-tree.nvim', version = vim.version.range('^3') },
})

if type(neotree.init) == 'function' then neotree.init() end

require('neo-tree').setup(neotree.opts)
require('window-picker').setup(window_picker.opts)

vim.keymap.set('n', '<leader>e', function() require('neo-tree.command').execute({ toggle = true }) end)

vim.keymap.set('n', '<leader>n', function() require('neo-tree.command').execute({ focus = true }) end)
