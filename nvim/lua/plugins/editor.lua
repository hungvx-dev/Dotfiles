local telescope = require("plugins.configs.editor.telescope")
local todo_comments = require("plugins.configs.editor.todo-comments")
local neotree = require("plugins.configs.editor.neotree")
local window_picker = require("plugins.configs.editor.window-picker")
local indent = require("plugins.configs.editor.indent-blankline")
local colorizer = require("plugins.configs.editor.colorizer")
local git_signs = require("plugins.configs.editor.git.signs")
local eyeliner = require("plugins.configs.editor.eyeliner")
local trouble = require("plugins.configs.editor.trouble")

return {
  -- File explorer
  {
    "nvim-neo-tree/neo-tree.nvim",
    cmd = "Neotree",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "mini.icons",
      "MunifTanjim/nui.nvim",
      {
        "s1n7ax/nvim-window-picker",
        version = "2.*",
        opts = window_picker.opts,
      },
    },
    init = neotree.init,
    deactivate = neotree.deactivate,
    keys = neotree.keys,
    opts = neotree.opts,
  },

  -- fuzzy finder
  {
    "nvim-telescope/telescope.nvim",
    cmd = "Telescope",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "mini.icons",
      {
        "nvim-telescope/telescope-fzf-native.nvim",
        build = "cmake -S. -Bbuild -DCMAKE_BUILD_TYPE=Release && cmake --build build --config Release",
      },
    },
    keys = telescope.keys,
    opts = telescope.opts,
    config = telescope.setup,
  },

  {
    "lukas-reineke/indent-blankline.nvim",
    main = "ibl",
    event = { "BufReadPost", "BufNewFile", "BufWritePre" },
    opts = indent.opts,
  },

  -- Comment
  {
    "folke/todo-comments.nvim",
    cmd = { "TodoTrouble", "TodoTelescope" },
    event = { "BufReadPost", "BufNewFile", "BufWritePre" },
    keys = todo_comments.keys,
    opts = todo_comments.opts,
  },
  {
    "numToStr/Comment.nvim",
    event = { "BufReadPre", "BufNewFile" },
    dependencies = {
      "JoosepAlviste/nvim-ts-context-commentstring",
    },
    config = require("plugins.configs.editor.comment").setup,
  },

  {
    "NvChad/nvim-colorizer.lua",
    event = { "BufReadPre", "BufNewFile" },
    opts = colorizer.opts,
  },

  -- Git
  {
    "lewis6991/gitsigns.nvim",
    event = { "BufReadPre", "BufNewFile" },
    opts = git_signs.opts,
  },
  {
    "akinsho/git-conflict.nvim",
    event = { "BufReadPre" },
    version = "*",
    config = true,
  },

  {
    "echasnovski/mini.bufremove",
    keys = {
      {
        "<leader>bd",
        function()
          require("mini.bufremove").delete(0, false)
        end,
        desc = "Delete Buffer",
      },
      {
        "<leader>bD",
        function()
          require("mini.bufremove").delete(0, true)
        end,
        desc = "Delete Buffer (Force)",
      },
    },
  },

  -- better diagnostics list and others
  {
    "folke/trouble.nvim",
    cmd = { "Trouble" },
    opts = trouble.opts,
    keys = trouble.keys,
  },

  -- easily jump
  {
    "jinh0/eyeliner.nvim",
    event = { "BufReadPre", "BufNewFile" },
    opts = eyeliner.opts,
  },
  {
    "rhysd/clever-f.vim",
    enabled = false,
    event = { "BufReadPre", "BufNewFile" },
    dependencies = { "eyeliner.nvim" },
    init = function()
      vim.g.clever_f_not_overwrites_standard_mappings = 1
    end,
    config = function()
      require("plugins.configs.editor.clever-f")
    end,
  },
  {
    "mg979/vim-visual-multi",
    event = { "BufReadPre", "BufNewFile" },
    init = function()
      vim.g.VM_set_statusline = 0
      vim.g.VM_silent_exit = 1
    end,
  },

  {
    "0x00-ketsu/maximizer.nvim",
    enabled = true,
    keys = {
      { "<C-w>f", "<cmd>lua require('maximizer').toggle()<CR>", desc = "Maximize/minimize a split" },
    },
    opts = {},
  },

  -- Dap
  {
    "mfussenegger/nvim-dap",
    enabled = false,
    dependencies = {
      -- fancy UI for the debugger
      {
        "rcarriga/nvim-dap-ui",
        enabled = false,
        keys = require("plugins.configs.editor.dap.ui").keys,
        opts = {},
        config = require("plugins.configs.editor.dap.ui").setup,
      },
      -- mason.nvim integration
      {
        "jay-babu/mason-nvim-dap.nvim",
        enabled = false,
        dependencies = "mason.nvim",
        cmd = { "DapInstall", "DapUninstall" },
        opts = {
          automatic_installation = true,
          handlers = {},
          ensure_installed = { "node2", "chrome" },
        },
      },
    },
    keys = require("plugins.configs.editor.dap.core").keys,
    config = require("plugins.configs.editor.dap.core").setup,
  },

  {
    "m4xshen/hardtime.nvim",
    dependencies = { "MunifTanjim/nui.nvim", "nvim-lua/plenary.nvim" },
    enabled = false,
    event = "BufEnter",
    opts = {
      disabled_filetypes = { "qf", "netrw", "lazy", "mason", "neo-tree" },
    },
  },
}
