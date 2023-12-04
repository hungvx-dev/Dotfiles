return {
  {
    "williamboman/mason.nvim",
    cmd = { "Mason", "MasonInstall", "MasonUninstall", "MasonUninstallAll", "MasonLog" },
    build = ":MasonUpdate",
    dependencies = {
      "williamboman/mason-lspconfig.nvim",
    },
    config = require("plugins.configs.lsp.mason").setup,
  },
  {
    "williamboman/mason-lspconfig.nvim",
    cmd = { "LspInstall", "LspUninstall" },
  },
  {
    "neovim/nvim-lspconfig",
    event = { "BufReadPre", "BufNewFile" },
    dependencies = {
      "hrsh7th/cmp-nvim-lsp",
      "williamboman/mason-lspconfig.nvim",
      "antosha417/nvim-lsp-file-operations",
      "jose-elias-alvarez/typescript.nvim",
      "b0o/SchemaStore.nvim",
    },
    config = require("plugins.configs.lsp.nvim-lspconfig").setup,
  },

  {
    "nvimtools/none-ls.nvim",
    -- enable = false,
    event = { "BufReadPost", "BufNewFile", "BufWritePre" },
    dependencies = {
      "nvim-lua/plenary.nvim",
      "davidmh/cspell.nvim",
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
