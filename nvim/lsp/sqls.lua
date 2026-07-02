---@brief
---
--- https://github.com/sqls-server/sqls
---
--- ```lua
--- vim.lsp.config('sqls', {
---   cmd = {"path/to/command", "-config", "path/to/config.yml"};
---   ...
--- })
--- ```
--- Sqls can be installed via `go install github.com/sqls-server/sqls@latest`. Instructions for compiling Sqls from the source can be found at [sqls-server/sqls](https://github.com/sqls-server/sqls).

---@type vim.lsp.Config
return {
  cmd = { 'sqls' },
  filetypes = { 'sql', 'mysql' },
  root_markers = { 'config.yml' },
  settings = {
    sqls = {
      connections = {
        -- {
        --   driver = 'postgresql',
        --   dataSourceName = 'postgresql://saas_mise:saas_mise@localhost:5432/mise?schema=public',
        -- },
        {
          driver = 'postgresql',
          dataSourceName = 'host=localhost port=5432 user=saas_mise password=saas_mise dbname=mise sslmode=disable',
        },
      },
    },
  },
  on_attach = function(client, bufnr)
    require('sqls').on_attach(client, bufnr) -- require sqls.nvim
  end,
}
