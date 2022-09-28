-- Setup installer & lsp configs
local typescript_ok, typescript = pcall(require, 'typescript')
local mason_ok, mason = pcall(require, 'mason')
local mason_lsp_ok, mason_lsp = pcall(require, 'mason-lspconfig')
local ufo_config = require('plugins.nvim-ufo')

if not mason_ok or not mason_lsp_ok then
  return
end

local servers = {
  "cssls",
  "cssmodules_ls",
  "emmet_ls",
  "eslint",
  "html",
  "tailwindcss",
  "jsonls",
  "sumneko_lua",
  "yamlls",
  "bashls",
  "tsserver",
  "volar",
  -- "vls",
  "graphql",
  "diagnosticls",
  "dockerls",
}

mason.setup {
  ui = {
    -- The border to use for the UI window. Accepts same border values as |nvim_open_win()|.
    border = EcoVim.ui.float.border or "rounded",
  }
}

mason_lsp.setup {
  -- A list of servers to automatically install if they're not already installed
  ensure_installed = servers,

  -- Whether servers that are set up (via lspconfig) should be automatically installed if they're not already installed.
  -- This setting has no relation with the `ensure_installed` setting.
  -- Can either be:
  --   - false: Servers are not automatically installed.
  --   - true: All servers set up via lspconfig are automatically installed.
  --   - { exclude: string[] }: All servers set up via lspconfig, except the ones provided in the list, are automatically installed.
  --       Example: automatic_installation = { exclude = { "rust_analyzer", "solargraph" } }
  automatic_installation = true,
}

local lspconfig = require("lspconfig")

local opts = { noremap = true, silent = true }
vim.keymap.set('n', '!', vim.diagnostic.open_float, opts)
vim.keymap.set("n", "[d", vim.diagnostic.goto_prev, opts)
vim.keymap.set("n", "]d", vim.diagnostic.goto_next, opts)

local handlers = {
  ["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, { border = EcoVim.ui.float.border,
    focusable = false,
  }),
  ["textDocument/signatureHelp"] = vim.lsp.with(vim.lsp.handlers.signature_help, { border = EcoVim.ui.float.border,
    focusable = false,
    virtual_text = EcoVim.lsp.virtual_text,
  }),
  ["textDocument/publishDiagnostics"] = vim.lsp.with(vim.lsp.diagnostic.on_publish_diagnostics,
    {
      border = EcoVim.ui.float.border,
      virtual_text = EcoVim.lsp.virtual_text,
      focusable = false,
    }),
}

local function lsp_keymaps(bufnr)
  vim.api.nvim_buf_set_option(bufnr, "omnifunc", "v:lua.vim.lsp.omnifunc")
  local opts = { noremap = true, silent = true }
  local bufopts = { noremap = true, silent = true, buffer = bufnr }
  vim.keymap.set('n', 'gd', vim.lsp.buf.definition, bufopts)
  vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, bufopts)
  vim.keymap.set('n', 'K', vim.lsp.buf.hover, bufopts)
  vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, bufopts)
  vim.keymap.set('n', 'gR', vim.lsp.buf.references, bufopts)
  vim.keymap.set('n', 'gs', vim.lsp.buf.signature_help, bufopts)
  vim.keymap.set('n', 'gf', "<cmd>lua vim.lsp.buf.format({ async = true })<CR>", bufopts)
  vim.keymap.set('n', 'ga', vim.lsp.buf.code_action, bufopts)
end

local capabilities = vim.lsp.protocol.make_client_capabilities()
local cmp_nvim_lsp_ok, cmp_nvim_lsp = pcall(require, 'cmp_nvim_lsp')
if cmp_nvim_lsp_ok then
  capabilities = cmp_nvim_lsp.update_capabilities(vim.lsp.protocol.make_client_capabilities())
end

capabilities.textDocument.foldingRange = {
  dynamicRegistration = false,
  lineFoldingOnly = true
}

local function on_attach(client, bufnr)
  lsp_keymaps(bufnr)
  -- set up buffer keymaps, etc.
end

-- Order matters

-- It enables tsserver automatically so no need to call lspconfig.tsserver.setup
if typescript_ok then
  typescript.setup({
    disable_commands = false, -- prevent the plugin from creating Vim commands
    debug = false, -- enable debug logging for commands
    -- LSP Config options
    server = {
      capabilities = require('lsp.servers.tsserver').capabilities,
      handlers = require('lsp.servers.tsserver').handlers,
      on_attach = function(client, bufnr)
        lsp_keymaps(bufnr)
        require('lsp.servers.tsserver').on_attach(client, bufnr)
      end,
    }
  })
end

lspconfig.tailwindcss.setup {
  capabilities = require('lsp.servers.tailwindcss').capabilities,
  filetypes = require('lsp.servers.tailwindcss').filetypes,
  handlers = handlers,
  init_options = require('lsp.servers.tailwindcss').init_options,
  on_attach = function(client, bufnr)
    lsp_keymaps(bufnr)
    require('lsp.servers.tailwindcss').on_attach(client, bufnr)
  end,
  settings = require('lsp.servers.tailwindcss').settings
}

lspconfig.cssls.setup {
  capabilities = capabilities,
  handlers = handlers,
  on_attach = function(client, bufnr)
    lsp_keymaps(bufnr)
    require('lsp.servers.cssls').on_attach(client, bufnr)
  end
}

lspconfig.eslint.setup {
  capabilities = capabilities,
  handlers = handlers,
  on_attach = function(client, bufnr)
    lsp_keymaps(bufnr)
    require('lsp.servers.eslint').on_attach(client, bufnr)
  end,
  settings = require('lsp.servers.eslint').settings,
}

lspconfig.jsonls.setup {
  capabilities = capabilities,
  handlers = handlers,
  on_attach = on_attach,
  settings = require('lsp.servers.jsonls').settings,
}

lspconfig.sumneko_lua.setup {
  capabilities = capabilities,
  handlers = handlers,
  on_attach = on_attach,
  settings = require('lsp.servers.sumneko_lua').settings,
}

-- lspconfig.vuels.setup {
--   filetypes = require('lsp.servers.vuels').filetypes,
--   handlers = handlers,
--   init_options = require('lsp.servers.vuels').init_options,
--   on_attach = on_attach,
-- }

lspconfig.volar.setup {
  filetypes = { 'typescript', 'javascript', 'javascriptreact', 'typescriptreact', 'vue', 'json' },
  handlers = handlers,
  on_attach = on_attach,
}

for _, server in ipairs { "bashls", "graphql", "html", "volar", "prismals" } do
  lspconfig[server].setup {
    on_attach = on_attach,
    capabilities = capabilities,
    handlers = handlers,
  }
end

require('ufo').setup({
  fold_virt_text_handler = ufo_config.handler,
  close_fold_kinds = { "imports" }
})
