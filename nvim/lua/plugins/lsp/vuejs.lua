local lspconfig = require 'lspconfig'
local default_key = require 'plugins/lsp/default'

local vuels = require('cmp_nvim_lsp').update_capabilities(vim.lsp.protocol.make_client_capabilities())

lspconfig.vuels.setup({
  capabilities = vuels,
  on_attach = function(client, bufnr)
    client.server_capabilities.document_formatting = true
    if client.server_capabilities.document_formatting then
      vim.cmd([[
      augroup LspFormatting
      autocmd! * <buffer>
      autocmd BufWritePre <buffer> EslintFixAll
      augroup END
      ]])
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
      validation = {
        templateProps = true,
        style = true,
      },
      format = {
        options = {
          useTabs = true,
        },
        defaultFormatter = {
          html = "prettier",
          ts = "prettier-tslint",
          js = "prettier-eslint"
        },
      },
      languageFeatures = {
        updateImportOnFileMove = true
      },
      trace = {
        server ="messages"
      }
    },
    format = {
      enable = true, -- delegated to prettier via null_ls
      options = {
        useTabs = true,
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
  root_dir = lspconfig.util.root_pattern(".git","package.json", "vue.config.js", vim.fn.getcwd()),
})
