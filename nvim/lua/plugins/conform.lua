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
      local function formater_frontend(bufnr)
        if require("conform").get_formatter_info("biome", bufnr).available then
          return { "biome" }
        else
          return { "eslint_d", "prettierd" }
        end
      end

      return {
        default_format_opts = {
          timeout_ms = 1000,
          async = false, -- not recommended to change
          quiet = false, -- not recommended to change
          lsp_format = "fallback", -- not recommended to change
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

          graphql = formater_frontend,

          markdown = { "prettierd" },
          ["markdown.mdx"] = { "prettierd" },
          yaml = { "prettierd" },

          javascript = formater_frontend,
          typescript = formater_frontend,
          javascriptreact = formater_frontend,
          typescriptreact = formater_frontend,
          vue = formater_frontend,
          html = { "biome", "prettierd", stop_after_first = true },
          css = { "biome", "prettierd", stop_after_first = true },
          scss = { "biome", "prettierd", stop_after_first = true },
          less = { "biome", "prettierd", stop_after_first = true },
          json = { "biome", "prettierd", stop_after_first = true },
          jsonc = { "biome", "prettierd", stop_after_first = true },
        },
        formatters = {
          -- ["cargo-fmt"] = {
          --   command = "cargo",
          --   args = { "fmt", "--", "$FILENAME" },
          --   stdin = false,
          -- },
        },
      }
    end,
  },
}
