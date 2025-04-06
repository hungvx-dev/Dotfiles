return {
  {
    "lsp",
    dev = true,
    event = { "BufReadPre", "BufNewFile" },
    dependencies = { "mason.nvim" },
    opts = {
      lsp = {
        "c",
        "css",
        "cssmodules",
        "docker-compose",
        "docker",
        "emmet",
        "go",
        "html",
        "json",
        "lua",
        "nix",
        "rust",
        "tailwindcss",
        "vtsls",
        "vue",
        "yaml",
      },
      ---@type vim.diagnostic.Opts
      diagnostic = {
        -- underline = true,
        -- virtual_text = false,
        -- virtual_lines = { current_line = true },
        update_in_insert = false,
        severity_sort = true,
        -- float = {
        --   focusable = true,
        --   focus = false,
        --   border = "rounded",
        --   source = true,
        -- },
        signs = {
          text = {
            [vim.diagnostic.severity.ERROR] = HVIM.signs.Error,
            [vim.diagnostic.severity.WARN] = HVIM.signs.Warn,
            [vim.diagnostic.severity.INFO] = HVIM.signs.Info,
            [vim.diagnostic.severity.HINT] = HVIM.signs.Hint,
          },
        },
      },
    },
  },
  {
    "williamboman/mason.nvim",
    cmd = { "Mason", "MasonInstall", "MasonUninstall", "MasonUninstallAll", "MasonLog" },
    build = ":MasonUpdate",
    event = "VeryLazy",
    opts = {
      opts_extend = { "ensure_installed" },
      ensure_installed = {
        -- LSP
        "vtsls",
        "vue-language-server",
        "json-lsp",
        "html-lsp",
        "emmet-ls",
        "css-lsp",
        "cssmodules-language-server",
        "tailwindcss-language-server",
        "lua-language-server",
        "yaml-language-server",
        "clangd",
        "gopls",
        "rust-analyzer",
        "nil",
        "dockerfile-language-server",
        "docker-compose-language-service",

        -- For Formatter
        "stylua", -- For lua
        "shfmt", -- For sh
        "prettierd", -- For js
        "clang-format", -- For c/c++
        "nixpkgs-fmt", -- For nix
        -- "google-java-format", -- For java
        "goimports", -- For go
        "gofumpt", -- For go

        -- For Linter
        "eslint_d", -- For js
        "hadolint", -- For docker
        "cspell",
        "oxlint",
        -- "stylelint",

        -- For Code action
        "gomodifytags", -- For go
        "impl", -- For go
      },
      ui = {
        border = "rounded",
        icons = {
          package_installed = HVIM.icons.Mason.Installed,
          package_pending = HVIM.icons.Mason.Pending,
          package_uninstalled = HVIM.icons.Mason.Uninstall,
        },
      },
    },
    config = function(_, opts)
      require("mason").setup(opts)
      local mr = require("mason-registry")
      mr:on("package:install:success", function()
        vim.defer_fn(function()
          -- trigger FileType event to possibly load this newly installed LSP server
          require("lazy.core.handler.event").trigger({
            event = "FileType",
            buf = vim.api.nvim_get_current_buf(),
          })
        end, 100)
      end)

      mr.refresh(function()
        for _, tool in ipairs(opts.ensure_installed) do
          local p = mr.get_package(tool)
          if not p:is_installed() then
            p:install()
          end
        end
      end)
    end,
  },
  {
    "antosha417/nvim-lsp-file-operations",
    -- enabled = HVIM.plugins.lsp,
    dependencies = { "nvim-lua/plenary.nvim" },
    opts = {},
  },
  {
    "j-hui/fidget.nvim",
    enabled = true,
    event = "LspAttach",
    opts = {
      notification = {
        window = {
          border = "rounded",
          winblend = 0,
        },
      },
      integration = {
        ["neo-tree"] = {
          enable = true,
        },
      },
    },
  },
}
