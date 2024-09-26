return {
  -- Treesitter
  {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    event = { "BufReadPre", "BufNewFile" },
    dependencies = {
      { "nvim-treesitter/nvim-treesitter-textobjects", event = { "BufReadPost" } },
      {
        "windwp/nvim-ts-autotag",
        event = { "BufReadPost" },
        config = require("plugins.configs.coding.autotag").setup,
      },
      {
        "hiphish/rainbow-delimiters.nvim",
      },
    },
    config = require("plugins.configs.coding.treesitter").setup,
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
      { "roobert/tailwindcss-colorizer-cmp.nvim", opts = {}, enabled = false },
      {
        "windwp/nvim-autopairs",
        config = require("plugins.configs.coding.autopairs").setup,
      },
    },
    config = require("plugins.configs.coding.cmp").setup,
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
