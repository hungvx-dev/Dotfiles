return {
  cmd = {"vscode-eslint-language-server", "--stdio"},
  bin = 'eslint_d', -- or `eslint_d`
  filetypes = {"javascript", "javascriptreact", "javascript.jsx", "typescript", "typescriptreact", "typescript.tsx", "vue"},
  init_options = {documentFormatting = true},
  settings = {
    codeAction = {
      enable = true,
      applyOnSave = {
        enable = true,
        types = { "problem" }, -- "directive", "problem", "suggestion", "layout"
      },
      disableRuleComment = {
        enable = true,
        location = "separateLine"
      },
      showDocumentation = {
        enable = true
      }
    },
    codeActionOnSave = {
      enable = true,
      mode = "all"
    },
    format = true,
    onIgnoredFiles = "off",
    packageManager = "npm",
    quiet = false,
    run = "onType",
    useESLintClass = false,
    validate = "on",
    workingDirectory = {mode = "location"},
  },
  diagnostics = {
    enable = true,
    report_unused_disable_directives = false,
    run_on = "type", -- or `save`
  },
}
