---@type vim.lsp.Config
return {
	cmd = { "docker-compose-langserver", "--stdio" },
	filetypes = { "yaml.docker-compose" },
	root_markers = { "docker-compose.yaml", "docker-compose.yml", "compose.yaml", "compose.yml" },
	single_file_support = true,
  on_attach = function(client, bufnr)
    vim.lsp.config["*"].on_attach(client, bufnr)
  end,
}
