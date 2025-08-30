---@type vim.lsp.Config
return {
  cmd = { "cssmodules-language-server", "--stdio" },
  filetypes = {
    -- "javascript",
    "javascriptreact",
    -- "typescript",
    "typescriptreact",
    "vue",
  },
  root_markers = { "package.json" },
  on_attach = function(client, bufnr)
    vim.lsp.config["*"].on_attach(client, bufnr)
  end,
}
