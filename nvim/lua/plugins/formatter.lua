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

        graphql = { "prettierd" },

        markdown = { "prettierd" },
        ["markdown.mdx"] = { "prettierd" },
        yaml = { "prettierd" },

        javascript = { "prettier", "eslint_d" }, -- Chạy prettier trước, sau đó eslint_d để fix
        typescript = { "prettier", "eslint_d" },
        javascriptreact = { "prettier", "eslint_d" },
        typescriptreact = { "prettier", "eslint_d" },
        vue = { "prettierd", "eslint_d" },
        html = { "prettier" },
        css = { "prettier" },
        scss = { "prettierd" },
        less = { "prettierd" },
        json = { "prettier" },
        jsonc = { "prettierd" },
      },
    },
  },
}
