return {
  root_dir = require("lspconfig/util").root_pattern(
    "tailwind.config.js",
    "tailwind.config.cjs",
    "tailwind.config.mjs",
    "tailwind.config.ts",
    "postcss.config.js",
    "postcss.config.cjs",
    "postcss.config.mjs",
    "postcss.config.ts"
  ),
  filetypes = { "html", "typescriptreact", "vue", "javascriptreact", "typescript" },
  settings = {
    includeLanguages = {
      typescript = "javascript",
      typescriptreact = "javascript",
    },
    tailwindCSS = {
      emmetCompletions = true,
      experimental = {
        classRegex = {
          { "cva\\(([^)]*)\\)", "[\"'`]([^\"'`]*).*?[\"'`]" },
          { "cx\\(([^)]*)\\)",  "(?:'|\"|`)([^']*)(?:'|\"|`)" },
        },
      },
      validate = true,
      lint = {
        cssConflict = "error",
        invalidApply = "error",
        invalidConfigPath = "error",
        invalidScreen = "error",
        invalidTailwindDirective = "error",
        invalidVariant = "error",
        recommendedVariantOrder = "error",
      },
    },
  },

  handlers = {
    ["tailwindcss/getConfiguration"] = function(_, _, params, _, bufnr, _)
      vim.lsp.buf_notify(bufnr, "tailwindcss/getConfigurationResponse", { _id = params._id })
    end,
  },
}
