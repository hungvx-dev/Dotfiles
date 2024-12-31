return {
  {
    "stevearc/conform.nvim",
    enabled = false,
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
        timeout_ms = 3000,
        async = false, -- not recommended to change
        quiet = false, -- not recommended to change
        lsp_format = "fallback", -- not recommended to change
      },
      formatters_by_ft = {
        lua = { "stylua" },
        sh = { "shfmt" },
        css = { "prettierd" },
        graphql = { "prettierd" },
        handlebars = { "prettierd" },
        html = { "prettierd" },
        javascript = { "prettierd" },
        javascriptreact = { "prettierd" },
        json = { "prettierd" },
        jsonc = { "prettierd" },
        less = { "prettierd" },
        markdown = { "prettierd" },
        ["markdown.mdx"] = { "prettierd" },
        scss = { "prettierd" },
        typescript = { "prettierd" },
        typescriptreact = { "prettierd" },
        vue = {  "eslint_d", "prettierd"},
        yaml = { "prettierd" },
      },
    },
  },
}
