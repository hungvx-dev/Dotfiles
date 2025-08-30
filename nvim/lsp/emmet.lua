---@type vim.lsp.Config
return {
  cmd = { "emmet-language-server", "--stdio" },
  single_file_support = true,
  filetypes = { "html", "typescriptreact", "vue", "javascriptreact", "css", "sass", "scss", "typescript.tsx", "javascript.jsx" },
  init_options = { provideFormatter = true },
  on_attach = function(client, bufnr)
    vim.lsp.config["*"].on_attach(client, bufnr)
  end,
}
