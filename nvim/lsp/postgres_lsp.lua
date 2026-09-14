---@type vim.lsp.Config
return {
  cmd = { 'postgres-language-server', 'lsp-proxy' },
  filetypes = { 'sql' },
  single_file_support = true,
  root_markers = { 'postgres-language-server.jsonc' },
  workspace_required = true,
  -- settings = {
  --   postgres_lsp = {
  --     connection = {
  --       host = 'localhost',
  --       port = 5432,
  --       user = 'postgres',
  --       password = 'secretpassword',
  --       database = 'testdb',
  --     },
  --   },
  -- },
}
