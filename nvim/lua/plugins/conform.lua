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
          require("conform").format({ async = true })
        end,
        mode = { "n", "v" },
        desc = "Format Injected Langs",
      },
    },
    opts = {
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

        graphql = { "prettierd" },

        markdown = { "prettierd" },
        ["markdown.mdx"] = { "prettierd" },
        yaml = { "prettierd" },

        javascript = { "biome", "eslint_d", "prettier" },
        typescript = { "biome", "eslint_d", "prettier" },
        javascriptreact = { "biome", "eslint_d", "prettier" },
        typescriptreact = { "biome", "eslint_d", "prettier" },
        vue = { "biome", "eslint_d", "prettierd" },
        html = { "prettier" },
        css = { "prettier" },
        scss = { "prettierd" },
        less = { "prettierd" },
        json = { "prettier" },
        jsonc = { "prettierd" },
      },
      formatters = {
        -- ["cargo-fmt"] = {
        --   command = "cargo",
        --   args = { "fmt", "--", "$FILENAME" },
        --   stdin = false,
        -- },
      },
    },
  },
}
