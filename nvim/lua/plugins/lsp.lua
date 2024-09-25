return {
  {
    "williamboman/mason-lspconfig.nvim",
    cmd = { "LspInstall", "LspUninstall" },
    -- event = { "VeryLazy" },
    event = { "BufReadPre", "BufNewFile" },
    dependencies = { "mason.nvim", "nvim-lspconfig" },
    config = function()
      require("plugins.configs.lsp.mason-lspconfig").setup()
    end,
  },
  {
    "williamboman/mason.nvim",
    cmd = { "Mason", "MasonInstall", "MasonUninstall", "MasonUninstallAll", "MasonLog" },
    build = ":MasonUpdate",
  },
  {
    "neovim/nvim-lspconfig",
    dependencies = {
      "hrsh7th/cmp-nvim-lsp",
      {
        "b0o/SchemaStore.nvim",
        lazy = true,
        version = false,
      },
    },
  },

  {
    "antosha417/nvim-lsp-file-operations",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-neo-tree/neo-tree.nvim",
    },
    config = function()
      require("lsp-file-operations").setup()
    end,
  },

  {
    "nvimtools/none-ls.nvim",
    event = { "BufReadPost", "BufNewFile", "BufWritePre" },
    dependencies = {
      "nvim-lua/plenary.nvim",
      "davidmh/cspell.nvim",
      "nvimtools/none-ls-extras.nvim",
    },
    config = require("plugins.configs.lsp.none-ls").setup,
  },

  -- Format
  {
    "stevearc/conform.nvim",
    enabled = false,
    event = { "BufReadPre", "BufNewFile" },
    config = require("plugins.configs.lsp.formatting").setup,
  },

  -- Lint
  {
    "mfussenegger/nvim-lint",
    enabled = false,
    event = { "BufReadPre", "BufNewFile" },
    config = require("plugins.configs.lsp.linting").setup,
  },

  {
    "j-hui/fidget.nvim",
    enabled = false,
    tag = "legacy",
    event = "LspAttach",
  },
}
