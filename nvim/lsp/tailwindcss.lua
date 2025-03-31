---@type vim.lsp.Config
return {
  cmd = { "tailwindcss-language-server", "--stdio" },
  root_markers = {
    "tsconfig.json",
    "jsconfig.json",
    "package.json",
    "vite.config.ts",
    "vite.config.js",
  },
  filetypes = {
    -- html
    "html",
    "markdown",
    "mdx",
    -- css
    "css",
    "less",
    "sass",
    "scss",
    -- js
    "javascript",
    "javascriptreact",
    "typescript",
    "typescriptreact",
    -- mixed
    "vue",
  },
  settings = {
    tailwindCSS = {
      emmetCompletions = true,
      classFunctions = { "tw", "clsx", "cva", "cx" },
      -- experimental = {
      --   classRegex = {
      --     { "cva\\(([^)]*)\\)", "[\"'`]([^\"'`]*).*?[\"'`]" },
      --     { "cx\\(([^)]*)\\)", "(?:'|\"|`)([^']*)(?:'|\"|`)" },
      --   },
      -- },
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
      classAttributes = {
        "class",
        "className",
      },
    },
  },
}
