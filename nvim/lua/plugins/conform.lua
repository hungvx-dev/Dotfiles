return {
  {
    "stevearc/conform.nvim",
    enabled = true,
    dependencies = { "mason.nvim" },
    cmd = "ConformInfo",
    keys = {
      {
        "gf",
        function()
          require("conform").format()
        end,
        mode = { "n", "v" },
        desc = "Format Injected Langs",
      },
    },
    opts = function()
      return {
        default_format_opts = {
          timeout_ms = 2000,
          async      = true,
          quiet      = false,
          lsp_format = "fallback",
        },
        formatters_by_ft = {
          sh               = { "shfmt" },
          fish             = { "fish_indent" },

          cpp              = { "clang_format" },
          c                = { "clang_format" },
          go               = { "goimports", "gofumpt" },
          lua              = { "stylua" },
          java             = { "google_java_format" },
          -- rust = { "cargo-fmt" },

          markdown         = { "biome", "prettierd", stop_after_first = true },
          ["markdown.mdx"] = { "biome", "prettierd", stop_after_first = true },
          yaml             = { "biome", "prettierd", stop_after_first = true },

          graphql          = { "biome", "eslint_d", "prettierd", stop_after_first = true },
          javascript       = { "biome", "eslint_d", "prettierd", stop_after_first = true },
          typescript       = { "biome", "eslint_d", "prettierd", stop_after_first = true },
          javascriptreact  = { "biome", "eslint_d", "prettierd", stop_after_first = true },
          typescriptreact  = { "biome", "eslint_d", "prettierd", stop_after_first = true },
          vue              = { "biome", "eslint_d", "prettierd", stop_after_first = true },
          html             = { "biome", "prettierd", stop_after_first = true },
          css              = { "biome", "prettierd", stop_after_first = true },
          scss             = { "biome", "prettierd", stop_after_first = true },
          less             = { "biome", "prettierd", stop_after_first = true },
          json             = { "biome", "prettierd", stop_after_first = true },
          jsonc            = { "biome", "prettierd", stop_after_first = true },
        },
        formatters = {
          biome = {
            require_cwd = true,
            condition   = function()
              local config_files = { "biome.json", "biome.jsonc" }
              for _, config_file in ipairs(config_files) do
                local path = vim.fn.findfile(config_file, vim.fn.getcwd() .. ";")
                if path ~= "" and vim.fn.filereadable(path) == 1 then
                  return true
                end
              end
              return false
            end,
          },
          eslint_d = {
            condition = function()
              local config_files = {
                ".eslintrc",
                ".eslintrc.js",
                ".eslintrc.cjs",
                ".eslintrc.yaml",
                ".eslintrc.yml",
                ".eslintrc.json",
                "eslint.config.js",
                "eslint.config.mjs",
                "eslint.config.cjs",
                "eslint.config.ts",
                "eslint.config.mts",
                "eslint.config.cts",
              }
              for _, config_file in ipairs(config_files) do
                if vim.fn.filereadable(vim.fn.findfile(config_file, vim.fn.getcwd() .. ";")) == 1 then
                  return true
                end
              end
              return false
            end,
          },
        },
      }
    end,
  },
}
