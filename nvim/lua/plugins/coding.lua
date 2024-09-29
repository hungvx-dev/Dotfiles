return {
  -- Treesitter
  {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    event = { "BufReadPre", "BufNewFile" },
    dependencies = {
      "nvim-ts-autotag",
      "nvim-autopairs",
      "hiphish/rainbow-delimiters.nvim",
      { "nvim-treesitter/nvim-treesitter-textobjects" },
    },
    config = require("plugins.configs.coding.treesitter").setup,
  },

  {
    "windwp/nvim-ts-autotag",
    config = require("plugins.configs.coding.autotag").setup,
  },
  {
    "windwp/nvim-autopairs",
    config = require("plugins.configs.coding.autopairs").setup,
  },

  -- auto completion
  {
    "hrsh7th/nvim-cmp",
    event = { "InsertEnter", "CmdlineEnter" },
    dependencies = {
      "hrsh7th/cmp-buffer",
      "hrsh7th/cmp-path",
      "hrsh7th/cmp-cmdline",
      "L3MON4D3/LuaSnip",
      "saadparwaiz1/cmp_luasnip",
      "nvim-autopairs",
      { "roobert/tailwindcss-colorizer-cmp.nvim", enabled = false },
    },
    config = require("plugins.configs.coding.cmp").setup,
  },

  -- snippets
  {
    "L3MON4D3/LuaSnip",
    event = { "InsertEnter" },
    build = "make install_jsregexp",
    dependencies = {
      {
        "rafamadriz/friendly-snippets",
        config = function()
          require("luasnip.loaders.from_vscode").lazy_load()
        end,
      },
    },
    opts = {
      history = true,
      delete_check_events = "TextChanged",
    },
    keys = require("plugins.configs.coding.lua-snip").keys,
  },

  {
    "github/copilot.vim",
    enabled = false,
    event = { "BufReadPre", "BufNewFile" },
  },

  {
    "kylechui/nvim-surround",
    enabled = true,
    event = { "BufReadPre", "BufNewFile" },
    version = "*",
    config = true,
  },
}
