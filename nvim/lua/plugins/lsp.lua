return {
  {
    "neovim/nvim-lspconfig",
    dependencies = {
      "b0o/SchemaStore.nvim",
      "mason.nvim",
      "williamboman/mason-lspconfig.nvim",
    },
    event = { "BufReadPre", "BufNewFile" },
    config = require("plugins.configs.lsp.mason-lspconfig").setup,
  },

  {
    "williamboman/mason.nvim",
    cmd = { "Mason", "MasonInstall", "MasonUninstall", "MasonUninstallAll", "MasonLog" },
    build = ":MasonUpdate",
    opts = {
      opts_extend = { "ensure_installed" },
      ensure_installed = {
        -- For Formatter
        "stylua", -- For lua
        "shfmt", -- For sh
        "prettierd",
        "clang-format",
        "nixpkgs-fmt",
        -- "prettier",

        -- For Linter
        "eslint_d",
        "hadolint", -- For docker
        -- "cspell",
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
    dependencies = { "nvim-lua/plenary.nvim" },
    opts = {},
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
}
--   {
--     "j-hui/fidget.nvim",
--     enabled = false,
--     tag = "legacy",
--     event = "LspAttach",
--   },
-- }
