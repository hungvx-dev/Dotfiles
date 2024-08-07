return {
  -- lspconfig
  {
    "neovim/nvim-lspconfig",
    event = { "BufReadPre", "BufNewFile" },
    lazy = true,
    dependencies = {
      "jose-elias-alvarez/typescript.nvim",
      { "b0o/SchemaStore.nvim", version = false, lazy = true },
    },
    opts = require "lsp.opts",
    config = function(_, opts)
      require("lsp").setup(opts)
    end,
  },
  {
    "williamboman/mason.nvim",
    cmd = { "Mason", "MasonInstall", "MasonUninstall", "MasonUninstallAll", "MasonLog" },
    build = ":MasonUpdate",
    lazy = true,
    config = function()
      require("lsp.mason").setup()
    end,
  },
  {
    "williamboman/mason-lspconfig.nvim",
    cmd = { "LspInstall", "LspUninstall" },
    lazy = false,
    dependencies = "mason.nvim",
  },

  -- auto completion
  {
    "hrsh7th/nvim-cmp",
    version = false, -- last release is way too old
    event = { "InsertEnter" },
    lazy = true,
    dependencies = {
      { "hrsh7th/cmp-nvim-lsp", lazy = true },
      { "hrsh7th/cmp-buffer", lazy = true },
      { "hrsh7th/cmp-path", lazy = true },
      { "f3fora/cmp-spell", lazy = true },
      { "saadparwaiz1/cmp_luasnip", lazy = true },
      { "hrsh7th/cmp-cmdline", lazy = true },
      -- { "tzachar/cmp-tabnine", build = "./install.sh" },
    },
    config = function()
      require("plugins.configs.completion.cmp").setup()
    end,
  },

  -- snippets
  {
    "L3MON4D3/LuaSnip",
    event = { "InsertEnter" },
    build = (not jit.os:find "Windows")
        and "echo 'NOTE: jsregexp is optional, so not a big deal if it fails to build'; make install_jsregexp"
      or nil,
    dependencies = {
      {
        "rafamadriz/friendly-snippets",
        event = { "InsertEnter" },
        lazy = true,
        cond = hvim.builtin.luasnip.sources.friendly_snippets,
      },
    },
    config = function()
      require("luasnip.loaders.from_vscode").lazy_load()
    end,
  },

  -- null-ls
  {
    "nvimtools/none-ls.nvim",
    event = { "BufReadPre", "BufNewFile" },
    dependencies = { "mason.nvim" },
    lazy = true,
    enabled = true,
    config = function()
      require "lsp.null-ls"
    end,
  },

  -- Treesitter
  {
    "nvim-treesitter/nvim-treesitter",
    version = false, -- last release is way too old and doesn't work on Windows
    build = ":TSUpdate",
    event = { "BufReadPost" },
    lazy = true,
    dependencies = {
      { "JoosepAlviste/nvim-ts-context-commentstring", lazy = true, event = { "BufReadPost" } },
      { "windwp/nvim-ts-autotag", lazy = true, event = { "BufReadPost" } },
      { "nvim-treesitter/nvim-treesitter-textobjects", lazy = true, event = { "BufReadPost" } },
    },
    keys = {
      { "<c-space>", desc = "Increment selection" },
      { "<bs>", desc = "Decrement selection", mode = "x" },
    },
    config = function()
      require("plugins.configs.treesitter").setup()
    end,
  },

  -- auto pairs
  {
    "windwp/nvim-autopairs",
    event = "InsertEnter",
    opts = { history = true, delete_check_events = "TextChanged" },
    dependencies = { "nvim-treesitter/nvim-treesitter", "hrsh7th/nvim-cmp" },
    config = function()
      require("plugins.configs.autopairs").setup()
    end,
  },

  -- surround
  { "kylechui/nvim-surround", config = true },
}
