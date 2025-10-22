---@type vim.lsp.Config
return {
  cmd = { "emmet-language-server", "--stdio" },
  single_file_support = true,
  filetypes = {
    "html",
    "typescriptreact",
    "javascriptreact",
    "css",
    "sass",
    "scss",
    "typescript.tsx",
    "javascript.jsx",
    "vue",
    "svg",
    "xml"
  },
  init_options = { provideFormatter = true },
}
