local lspconfig = require 'lspconfig'
local default_key = require 'plugins/lsp/default'

local vuels = require('cmp_nvim_lsp').update_capabilities(vim.lsp.protocol.make_client_capabilities())

lspconfig.vuels.setup({
  capabilities = vuels,
  on_attach = function(client, bufnr)
    client.resolved_capabilities.document_formatting = true
    if client.resolved_capabilities.document_formatting then
      vim.cmd([[
      augroup LspFormatting
      autocmd! * <buffer>
      autocmd BufWritePre <buffer> EslintFixAll
      augroup END
      ]])
      -- vim.cmd([[
      -- augroup LspFormatting
      -- autocmd! * <buffer>
      -- autocmd BufWritePre <buffer> PrettierAsync
      -- augroup END
      -- ]])
    end
    -- no default maps, so you may want to define some here
    default_key(client, bufnr)
  end,
  settings = {
    vetur = {
      completion = {
        autoImport = true,
        tagCasing = "kebab",
        useScaffoldSnippets = true,
      },
      useWorkspaceDependencies = true,
      experimental = {
        templateInterpolationService = true,
      },
    },
    format = {
      enable = false, -- delegated to prettier via null_ls
      options = {
        useTabs = false,
        tabSize = 2,
      },
      defaultFormatter = {
        ts = "prettier",
      },
      scriptInitialIndent = true,
      styleInitialIndent = true,
    },
    validation = {
      template = true,
      script = true,
      style = true,
      templateProps = true,
      interpolation = true,
    },
  },
})
