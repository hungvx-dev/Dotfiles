j
-- local default_key = require 'plugins/lsp/default'

-- local capabilities = require('cmp_nvim_lsp').update_capabilities(vim.lsp.protocol.make_client_capabilities())
-- capabilities.textDocument.completion.completionItem.snippetSupport = true

-- lspconfig.cssls.setup({
--   capabilities = capabilities,
--   on_attach = function(client, bufnr)
--     client.server_capabilities.document_formatting = true
--     default_key(client, bufnr)
--   end
-- })

-- lspconfig.html.setup {
--   on_attach = on_attach,
--   capabilities = capabilities,
--   root_dir = lspconfig.util.root_pattern(".git", vim.fn.getcwd()),
-- }
