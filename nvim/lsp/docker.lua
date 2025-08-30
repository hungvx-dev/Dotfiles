---@type vim.lsp.Config
return {
  cmd = { "docker-langserver", "--stdio" },
  single_file_support = true,
  filetypes = { "dockerfile" },
  root_markers = { "Dockerfile" },
  on_attach = function(client, bufnr)
    vim.lsp.config["*"].on_attach(client, bufnr)
  end,
}
