---@type vim.lsp.Config
return {
  cmd = { "tailwindcss-language-server", "--stdio" },
  root_markers = {
    "package.json",
    "tailwind.config.js",
    "tailwind.config.cjs",
    "tailwind.config.mjs",
    "tailwind.config.ts",
    "postcss.config.js",
    "postcss.config.cjs",
    "postcss.config.mjs",
    "postcss.config.ts",
  },
  filetypes = {
    -- html
    "html",
    -- "markdown",
    -- "mdx",
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
      includeLanguages = {
        eelixir = "html-eex",
        eruby = "erb",
        templ = "html",
        htmlangular = "html",
      },
      emmetCompletions = true,
      classFunctions = { "tw", "clsx", "cva", "cx" },
      -- experimental = {
      --   classRegex = {
      --     { "cva\\(([^)]*)\\)", "[\"'`]([^\"'`]*).*?[\"'`]" },
      --     { "cx\\(([^)]*)\\)", "(?:'|\"|`)([^']*)(?:'|\"|`)" },
      --   },
      -- },
    },
  },
  on_attach = function(client, bufnr)
    vim.lsp.config["*"].on_attach(client, bufnr)
  end,
}
