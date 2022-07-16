local lspconfig = require'lspconfig'
local default_key = require 'plugins/lsp/default'
local json = require('cmp_nvim_lsp').update_capabilities(vim.lsp.protocol.make_client_capabilities())

lspconfig.jsonls.setup({
  capabilities = json,
  on_attach = default_key,
  settings = {
    json = {
      schemas = require("schemastore").json.schemas(),
      validate = { enable = true },
    },
  },
})
