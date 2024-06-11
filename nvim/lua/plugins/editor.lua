return {
  -- File explorer
  {
    "nvim-neo-tree/neo-tree.nvim",
    cmd = "Neotree",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-tree/nvim-web-devicons",
      "MunifTanjim/nui.nvim",
      {
        "s1n7ax/nvim-window-picker",
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
    config = require("plugins.configs.editor.neo-tree").setup,
  },

  -- fuzzy finder
  {
    "nvim-telescope/telescope.nvim",
    cmd = "Telescope",
    dependencies = {
      "nvim-lua/plenary.nvim",
      { "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
      "nvim-tree/nvim-web-devicons",
    },
    keys = require("plugins.configs.editor.telescope").keys,
    config = require("plugins.configs.editor.telescope").setup,
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
    keys = require("plugins.configs.editor.todo-comments").keys,
    config = require("plugins.configs.editor.todo-comments").setup,
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
    -- cmd = { "TroubleToggle", "Trouble" },
    opts = { use_diagnostic_signs = true },
    keys = require("plugins.configs.editor.trouble").keys,
  },

  -- easily jump
  {
    "unblevable/quick-scope",
    event = { "BufReadPre", "BufNewFile" },
    config = function()
      require("plugins.configs.editor.quick-scope")
    end,
  },
  {
    "mg979/vim-visual-multi",
    event = { "BufReadPre", "BufNewFile" },
    config = function()
      vim.g.VM_leader = "\\"
    end,
  },
  {
    "0x00-ketsu/maximizer.nvim",
    enabled = false,
    config = function()
      require("maximizer").setup({
        -- your configuration comes here
        -- or leave it empty to use the default settings
        -- refer to the configuration section below
      })
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
        keys = require("plugins.configs.editor.dap.ui").keys,
        opts = {},
        config = require("plugins.configs.editor.dap.ui").setup,
      },
      -- mason.nvim integration
      {
        "jay-babu/mason-nvim-dap.nvim",
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
