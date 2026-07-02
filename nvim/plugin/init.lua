vim.pack.add({
  -- Core
  { src = 'https://github.com/nvim-lua/plenary.nvim' },
  { src = 'https://github.com/MunifTanjim/nui.nvim' },

  -- Editor
  { src = 'https://github.com/echasnovski/mini.icons' },
  { src = 'https://github.com/catgoose/nvim-colorizer.lua' },
  { src = 'https://github.com/akinsho/bufferline.nvim', version = vim.version.range('*') },
  { src = 'https://github.com/stevearc/dressing.nvim' },
  { src = 'https://github.com/s1n7ax/nvim-window-picker', version = vim.version.range('2.*') },
  { src = 'https://github.com/nvim-neo-tree/neo-tree.nvim', version = vim.version.range('^3') },
  { src = 'https://github.com/jinh0/eyeliner.nvim' },
  { src = 'https://github.com/ibhagwan/fzf-lua' },
  { src = 'https://github.com/lewis6991/gitsigns.nvim', version = vim.version.range('*') },

  -- Coding
  { src = 'https://github.com/mason-org/mason.nvim' },
  { src = 'https://github.com/windwp/nvim-ts-autotag' },
  { src = 'https://github.com/JoosepAlviste/nvim-ts-context-commentstring' },
  { src = 'https://github.com/echasnovski/mini.comment' },
  { src = 'https://github.com/folke/todo-comments.nvim' },
  { src = 'https://github.com/kylechui/nvim-surround', version = vim.version.range('4.*') },
  { src = 'https://github.com/mason-org/mason.nvim' },
  { src = 'https://github.com/stevearc/conform.nvim' },
  { src = 'https://github.com/j-hui/fidget.nvim' },
  { src = 'https://github.com/antosha417/nvim-lsp-file-operations' },
  { src = 'https://github.com/romus204/tree-sitter-manager.nvim' },
  { src = 'https://github.com/nvim-treesitter/nvim-treesitter-textobjects', version = 'main' },

  -- Blink
  { src = 'https://github.com/rafamadriz/friendly-snippets' },
  { src = 'https://github.com/xzbdmw/colorful-menu.nvim' },
  { src = 'https://github.com/saghen/blink.lib' },
  { src = 'https://github.com/saghen/blink.download' },
  { src = 'https://github.com/saghen/blink.cmp' },
  { src = 'https://github.com/saghen/blink.indent' },
  { src = 'https://github.com/saghen/blink.pairs', version = vim.version.range('*') },
  { src = 'https://github.com/nanotee/sqls.nvim' },
})

require('plugins')
