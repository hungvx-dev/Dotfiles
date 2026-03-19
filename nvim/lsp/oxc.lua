---@type vim.lsp.Config
return {
  cmd = { "oxc_language_server" },
  -- cmd = { "oxlint", "--lsp", "--type-aware", "--type-check" },
  filetypes = {
    "javascript",
    "javascriptreact",
    "javascript.jsx",
    "typescript",
    "typescriptreact",
    "typescript.tsx",
  },
  workspace_required = true,
  root_markers = { ".oxlintrc.json" },
}
