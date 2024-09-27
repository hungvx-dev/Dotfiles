local telescope = require("plugins.configs.editor.telescope")
local todo_comments = require("plugins.configs.editor.todo-comments")

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
        config = require("plugins.configs.editor.window-picker").setup,
      },
    },
    keys = {
      { "<leader>e", "<cmd>Neotree toggle<cr>", desc = "NeoTree toggle" },
      { "<leader>n", "<cmd>Neotree focus<cr>", desc = "NeoTree focus" },
    },
    deactivate = function()
      vim.cmd([[Neotree close]])
    end,
    init = function()
      if vim.fn.argc() == 1 then
        local stat = vim.loop.fs_stat(vim.fn.argv(0))
        if stat and stat.type == "directory" then
          require("neo-tree")
        end
      end
    end,
    config = require("plugins.configs.editor.neotree").setup,
  },

  -- fuzzy finder
  {
    "nvim-telescope/telescope.nvim",
    cmd = "Telescope",
    dependencies = {
      "nvim-lua/plenary.nvim",
      { "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
      "mini.icons",
    },
    keys = telescope.keys,
    config = telescope.setup,
  },

  {
    "lukas-reineke/indent-blankline.nvim",
    main = "ibl",
    event = { "BufReadPost", "BufNewFile", "BufWritePre" },
    config = require("plugins.configs.editor.indent-blankline").setup,
  },

  -- Comment
  {
    "folke/todo-comments.nvim",
    cmd = { "TodoTrouble", "TodoTelescope" },
    event = { "BufReadPost", "BufNewFile", "BufWritePre" },
    keys = todo_comments.keys,
    config = todo_comments.setup,
  },
  {
    "numToStr/Comment.nvim",
    event = { "BufReadPre", "BufNewFile" },
    dependencies = {
      { "JoosepAlviste/nvim-ts-context-commentstring", event = { "BufReadPost" } },
    },
    config = require("plugins.configs.editor.comment").setup,
  },

  {
    "NvChad/nvim-colorizer.lua",
    event = { "BufReadPre", "BufNewFile" },
    config = require("plugins.configs.editor.colorizer").setup,
  },

  -- Git
  {
    "lewis6991/gitsigns.nvim",
    event = { "BufReadPre", "BufNewFile" },
    config = require("plugins.configs.editor.git.signs").setup,
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
    opts = { use_diagnostic_signs = true },
    keys = require("plugins.configs.editor.trouble").keys,
  },

  -- easily jump
  {
    "jinh0/eyeliner.nvim",
    config = require("plugins.configs.editor.eyeliner").setup,
  },
  {
    "rhysd/clever-f.vim",
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
    config = function()
      vim.g.VM_set_statusline = 0
      vim.g.VM_silent_exit = 1
    end,
  },

  {
    "0x00-ketsu/maximizer.nvim",
    enabled = true,
    config = function()
      require("maximizer").setup({})
    end,
    keys = {
      { "<C-w>f", "<cmd>lua require('maximizer').toggle()<CR>", desc = "Maximize/minimize a split" },
    },
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
    config = function()
      require("hardtime").setup({
        disabled_filetypes = { "qf", "netrw", "lazy", "mason", "neo-tree" },
      })
    end,
  },
}
