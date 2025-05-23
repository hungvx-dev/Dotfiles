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
          timeout_ms = 1000,
          async = false,
          quiet = false,
          lsp_format = "fallback",
        },
        formatters_by_ft = {
          sh = { "shfmt" },
          fish = { "fish_indent" },

          cpp = { "clang_format" },
          c = { "clang_format" },
          go = { "goimports", "gofumpt" },
          lua = { "stylua" },
          java = { "google_java_format" },
          -- rust = { "cargo-fmt" },

          graphql = { "biome", "eslint_d", "prettierd" },

          markdown = { "biome", "prettierd" },
          ["markdown.mdx"] = { "biome", "prettierd" },
          yaml = { "biome", "prettierd" },

          javascript = { "biome", "eslint_d", "prettierd" },
          typescript = { "biome", "eslint_d", "prettierd" },
          javascriptreact = { "biome", "eslint_d", "prettierd" },
          typescriptreact = { "biome", "eslint_d", "prettierd" },
          vue = { "biome", "eslint_d", "prettierd" },
          html = { "biome", "prettierd", stop_after_first = true },
          css = { "biome", "prettierd", stop_after_first = true },
          scss = { "biome", "prettierd", stop_after_first = true },
          less = { "biome", "prettierd", stop_after_first = true },
          json = { "biome", "prettierd", stop_after_first = true },
          jsonc = { "biome", "prettierd", stop_after_first = true },
        },
        formatters = {
          biome = {
            require_cwd = true,
            condition = function()
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
              local config_files = { ".eslintrc", ".eslintrc.json", ".eslintrc.js", ".eslintrc.yaml", ".eslintrc.yml", "eslint.config.mts", "eslint.config.mjs" }
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
