return {
  cmd = {"vscode-eslint-language-server", "--stdio"},
  filetypes = {"javascript", "javascriptreact", "javascript.jsx", "typescript", "typescriptreact", "typescript.tsx", "vue"},
  init_options = {documentFormatting = true},
  settings = {
    codeAction = {disableRuleComment = {enable = true, location = "separateLine"}, showDocumentation = {enable = true}},
    codeActionOnSave = {enable = true, mode = "all"},
    format = true,
    onIgnoredFiles = "off",
    packageManager = "npm",
    quiet = false,
    run = "onType",
    useESLintClass = false,
    validate = "on",
    workingDirectory = {mode = "location"}
  }
}
