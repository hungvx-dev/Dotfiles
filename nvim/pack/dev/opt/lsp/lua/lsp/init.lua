---@diagnostic disable: unnecessary-if, unresolved-require, deprecated
local diagnostics = require('lsp.diagnostics')
local lsp_buf = require('lsp.lsp-buf')
local fzf = require('fzf-lua')

local function lsp_references()
  lsp_buf.references({
    reuse_win = true,
    on_list = function(items) fzf.lsp_references({ items = items }) end,
  })
end

local function lsp_definition()
  lsp_buf.definition({
    reuse_win = true,
    on_list = fzf.lsp_definitions,
  })
end

local function lsp_implementations()
  lsp_buf.implementation({
    reuse_win = true,
    on_list = fzf.lsp_implementations,
  })
end

local function lsp_typedefs()
  lsp_buf.type_definition({
    reuse_win = true,
    on_list = fzf.lsp_typedefs,
  })
end

local M = {}
local map = vim.keymap.set

function M.keymaps(client, buf)
  local opts = { buffer = buf, noremap = true }

  map('n', 'grr', lsp_references, opts)
  map('n', 'gd', lsp_definition, opts)
  map('n', 'gi', lsp_implementations, opts)
  map('n', 'gt', lsp_typedefs, opts)
  map({ 'n', 'v' }, 'ga', vim.lsp.buf.code_action, opts)
  map('n', 'gD', vim.lsp.buf.declaration, opts)

  if client:supports_method(vim.lsp.protocol.Methods.textDocument_inlayHint, buf) then
    map(
      'n',
      '<leader>gi',
      function() vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled({ bufnr = buf }), { bufnr = buf }) end,
      opts
    )
    -- client.server_capabilities.semanticTokensProvider = nil
  end
end

function M.setup(opts)
  M.opts = opts
  diagnostics.config_diagnostic(opts.diagnostic)

  local lsp_file = require('lsp-file-operations')

  vim.lsp.config('*', {
    capabilities = vim.tbl_deep_extend(
      'force',
      vim.lsp.protocol.make_client_capabilities(),
      lsp_file.default_capabilities()
    ),
  })

  vim.api.nvim_create_autocmd('LspAttach', {
    group = vim.api.nvim_create_augroup('UserLspConfig', {}),
    callback = function(ev)
      local client = vim.lsp.get_client_by_id(ev.data.client_id)
      if client ~= nil then M.keymaps(client, ev.buf) end
    end,
  })

  vim.lsp.enable(opts.lsp)
end

return M
