return {
  {
    "mfussenegger/nvim-lint",
    enabled = false,
    event = { "BufReadPost", "BufNewFile", "BufWritePre" },
    opts = {
      events = { "BufWritePost", "BufReadPost", "InsertLeave" },
      linters_by_ft = {
        -- css = { "eslint_d", "stylelint" },
        -- less = { "stylelint" },
        -- scss = { "eslint_d", "stylelint" },
        graphql = { "eslint_d" },
        html = { "eslint_d" },
        javascript = { "eslint_d" },
        javascriptreact = { "eslint_d" },
        json = { "eslint_d" },
        jsonc = { "eslint_d" },
        typescript = { "eslint_d" },
        typescriptreact = { "eslint_d" },
        vue = { "eslint_d" },
        -- yaml = { "yamllint" },
        docker = { "hadolint" },
      },
    },
    config = function(_, opts)
      local lint = require("lint")
      lint.linters_by_ft = opts.linters_by_ft
      vim.api.nvim_create_autocmd(opts.events, {
        callback = function()
          lint.try_lint()
        end,
      })
    end,
  },
}
