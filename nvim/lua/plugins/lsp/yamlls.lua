local lspconfig = require'lspconfig'
local default_key = require 'plugins/lsp/default'
local yamlls = require('cmp_nvim_lsp').update_capabilities(vim.lsp.protocol.make_client_capabilities())
lspconfig.yamlls.setup({
    capabilities = yamlls,
    on_attach = default_key,
})
