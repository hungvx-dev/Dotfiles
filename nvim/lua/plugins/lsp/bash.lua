local lspconfig = require 'lspconfig'
local default_key = require 'plugins/lsp/default'

local capabilities = require('cmp_nvim_lsp').update_capabilities(vim.lsp.protocol.make_client_capabilities())

lspconfig.bashls.setup({
    init_options = {documentFormatting = true},
    capabilities = capabilities,
    on_attach = function(client, bufnr)
        client.resolved_capabilities.document_formatting = true
        default_key(client, bufnr)
    end
})
