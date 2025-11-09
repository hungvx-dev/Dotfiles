return {
  {
    "mason-org/mason.nvim",
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
        "emmet-language-server",
        "css-lsp",
        "cssmodules-language-server",
        "tailwindcss-language-server",
        "lua-language-server",
        "typescript-language-server",
        "yaml-language-server",
        "clangd",
        "gopls",
        "rust-analyzer",
        "nil",
        "dockerfile-language-server",
        "docker-compose-language-service",
        "postgres-language-server",
        "luau-lsp",
        "eslint-lsp", -- For js

        -- For Formatter
        "stylua", -- For lua
        "shfmt", -- For sh
        "prettierd", -- For js
        "clang-format", -- For c/c++
        "nixpkgs-fmt", -- For nix
        -- "google-java-format", -- For java
        "goimports", -- For go
        "gofumpt", -- For go
        "yamllint",

        -- For Linter
        "typos-lsp",
        "eslint_d", -- For js
        "hadolint", -- For docker
        "oxlint",
        "biome",
        "selene",
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
      local registry = require("mason-registry")
      registry:on("package:install:success", function()
        vim.defer_fn(function()
          require("lazy.core.handler.event").trigger({
            event = "FileType",
            buf = vim.api.nvim_get_current_buf(),
          })
        end, 100)
      end)

      registry.refresh(function()
        for _, name in ipairs(opts.ensure_installed) do
          local ok, pkg = pcall(registry.get_package, name)
          if ok then
            if not pkg:is_installed() then
              pkg:install()
            end
          end
        end
      end)
    end,
  },
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
        "luau",
        "nix",
        "postgresql",
        "rust",
        "tailwindcss",
        "vtsls",
        -- "typescript",
        "vue",
        "yaml",
        "biome",
        "eslint",
        "typos-lsp",
      },
      ---@type vim.diagnostic.Opts
      diagnostic = {
        update_in_insert = false,
        severity_sort = true,
        -- underline = true,
        -- virtual_lines = { current_line = true },
        float = {
          focusable = true,
          focus = false,
          border = "rounded",
          source = "if_many",
        },
        signs = {
          text = {
            [vim.diagnostic.severity.ERROR] = HVIM.signs.Error,
            [vim.diagnostic.severity.WARN] = HVIM.signs.Warn,
            [vim.diagnostic.severity.INFO] = HVIM.signs.Info,
            [vim.diagnostic.severity.HINT] = HVIM.signs.Hint,
          },
        },
        -- virtual_text = {
        --   source = "if_many",
        --   spacing = 2,
        --   format = function(diagnostic)
        --     local diagnostic_message = {
        --       [vim.diagnostic.severity.ERROR] = diagnostic.message,
        --       [vim.diagnostic.severity.WARN] = diagnostic.message,
        --       [vim.diagnostic.severity.INFO] = diagnostic.message,
        --       [vim.diagnostic.severity.HINT] = diagnostic.message,
        --     }
        --     return diagnostic_message[diagnostic.severity]
        --   end,
        -- },
      },
    },
  },
  {
    "antosha417/nvim-lsp-file-operations",
    -- enabled = HVIM.plugins.lsp,
    dependencies = { "nvim-lua/plenary.nvim", "nvim-neo-tree/neo-tree.nvim" },
    opts = {
      operations = {
        willRenameFiles = true,
        didRenameFiles = true,
        willCreateFiles = true,
        didCreateFiles = true,
        willDeleteFiles = true,
        didDeleteFiles = true,
      },
    },
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
  {
    "RRethy/vim-illuminate",
    event = { "BufReadPost", "BufNewFile" },
    enabled = true,
    config = function()
      require("illuminate").configure({
        delay = 100,
        filetypes_denylist = {
          "dirbuf",
          "dirvish",
          "fugitive",
          "neo-tree",
          "alpha",
          "lazy",
          "help",
          "fzf",
          "TelescopePrompt",
          "TelescopeResult",
        },
        large_file_cutoff = 2000,
        large_file_overrides = {
          providers = { "lsp" },
        },
        -- modes_denylist = {},
        min_count_to_highlight = 2,
      })
    end,
  },
  {
    "razak17/tailwind-fold.nvim",
    ft = { "html", "vue", "typescriptreact" },
    dependencies = { "nvim-treesitter/nvim-treesitter" },
    opts = {},
  },
}
