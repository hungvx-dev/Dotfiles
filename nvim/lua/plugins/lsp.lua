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

  -- Format
  {
    "stevearc/conform.nvim",
    event = { "BufReadPre", "BufNewFile" },
    config = require("plugins.configs.lsp.formatting").setup,
  },

  -- Lint
  {
    "mfussenegger/nvim-lint",
    event = { "BufReadPre", "BufNewFile" },
    config = require("plugins.configs.lsp.linting").setup,
  },
}
