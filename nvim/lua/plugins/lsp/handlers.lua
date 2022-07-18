-- local cmd = vim.cmd

-- local default_key = function(client, bufnr)
--   require 'lsp_signature'.on_attach({auto_close_after = 3, transparency = 80, timer_interval = 100}, bufnr)
--   local opts_lsp = {noremap = true, silent = true}
--   vim.cmd("command! LspDe lua vim.lsp.buf.declaration()")
--   vim.cmd("command! LspDef lua vim.lsp.buf.definition()")
--   vim.cmd("command! LspFormatting lua vim.lsp.buf.format()")
--   vim.cmd("command! LspCodeAction lua require('telescope.builtin').lsp_code_actions()")
--   vim.cmd("command! LspHover lua vim.lsp.buf.hover()")
--   vim.cmd("command! LspRename lua vim.lsp.buf.rename()")
--   vim.cmd("command! LspRefs lua vim.lsp.buf.references()")
--   vim.cmd("command! LspTypeDef lua vim.lsp.buf.type_definition()")
--   vim.cmd("command! LspImplementation lua vim.lsp.buf.implementation()")
--   vim.cmd("command! LspDiagPrev lua vim.diagnostic.goto_prev()")
--   vim.cmd("command! LspDiagNext lua vim.diagnostic.goto_next()")
--   vim.cmd("command! LspDiagLine lua vim.diagnostic.open_float(nil, {focus = false})")
--   vim.cmd("command! LspSignatureHelp lua vim.lsp.buf.signature_help()")

--   vim.api.nvim_buf_set_keymap(bufnr, "n", "gD", ':LspDe<CR>', opts_lsp)
--   vim.api.nvim_buf_set_keymap(bufnr, "n", "gd", ":LspDef<CR>", opts_lsp)
--   vim.api.nvim_buf_set_keymap(bufnr, "n", "K", ":LspHover<CR>", opts_lsp)
--   -- vim.api.nvim_buf_set_keymap(bufnr, "n", "gt", ":LspTypeDef<CR>", opts_lsp)
--   vim.api.nvim_buf_set_keymap(bufnr, "n", "gR", ":LspRefs<CR>", opts_lsp)
--   vim.api.nvim_buf_set_keymap(bufnr, "n", "gi", ":LspImplementation<CR>", opts_lsp)
--   vim.api.nvim_buf_set_keymap(bufnr, "n", "ga", ":LspCodeAction<CR>", opts_lsp)
--   vim.api.nvim_buf_set_keymap(bufnr, 'n', '<space>rn', ':LspRename<CR>', opts_lsp)
--   vim.api.nvim_buf_set_keymap(bufnr, 'n', '!', ':LspDiagLine<CR>', opts_lsp)
--   vim.api.nvim_buf_set_keymap(bufnr, "n", 'gf', ':LspFormatting<CR>', opts_lsp)
--   -- vim.api.nvim_buf_set_keymap(bufnr, 'n', '<C-0>', ':LspDiagNext<CR>', opts_lsp)
--   -- vim.api.nvim_buf_set_keymap(bufnr, "n", '<C-9>', ':LspDiagPrev<CR>', opts_lsp)
-- end

-- return default_key

local M = {}

M.capabilities = vim.lsp.protocol.make_client_capabilities()

local status_cmp_ok, cmp_nvim_lsp = pcall(require, "cmp_nvim_lsp")
if not status_cmp_ok then
  return
end
M.capabilities.textDocument.completion.completionItem.snippetSupport = true
M.capabilities = cmp_nvim_lsp.update_capabilities(M.capabilities)

M.setup = function()
  local icons = require "plugins.icons"
  local signs = {
    { name = "DiagnosticSignError", text = icons.diagnostics.Error },
    { name = "DiagnosticSignWarn", text = icons.diagnostics.Warning },
    { name = "DiagnosticSignHint", text = icons.diagnostics.Hint },
    { name = "DiagnosticSignInfo", text = icons.diagnostics.Information },
  }

  for _, sign in ipairs(signs) do
    vim.fn.sign_define(sign.name, { texthl = sign.name, text = sign.text, numhl = "" })
  end

  local config = {
    -- disable virtual text
    virtual_text = false,
    -- show signs
    signs = {
      active = signs,
    },
    update_in_insert = true,
    underline = true,
    severity_sort = true,
    float = {
      focusable = true,
      style = "minimal",
      border = "rounded",
      source = "always",
      header = "",
      prefix = "",
      -- width = 40,
    },
  }

  vim.diagnostic.config(config)

  vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, {
    border = "rounded",
    width = 60,
    -- height = 30,
  })

  vim.lsp.handlers["textDocument/signatureHelp"] = vim.lsp.with(vim.lsp.handlers.signature_help, {
    border = "rounded",
    width = 60,
    -- height = 30,
  })
end

local function lsp_highlight_document(client)
  -- if client.server_capabilities.document_highlight then
  local status_ok, illuminate = pcall(require, "illuminate")
  if not status_ok then
    return
  end
  illuminate.on_attach(client)
  -- end
end

local function attach_navic(client, bufnr)
  vim.g.navic_silence = true
  local status_ok, navic = pcall(require, "nvim-navic")
  if not status_ok then
    return
  end
  navic.attach(client, bufnr)
end

local function lsp_keymaps(bufnr)
  local opts = { noremap = true, silent = true }
  vim.api.nvim_buf_set_keymap(bufnr, "n", "gd", "<cmd>lua vim.lsp.buf.definition()<CR>", opts)
  vim.api.nvim_buf_set_keymap(bufnr, "n", "gD", "<cmd>lua vim.lsp.buf.declaration()<CR>", opts)
  vim.api.nvim_buf_set_keymap(bufnr, "n", "K", "<cmd>lua vim.lsp.buf.hover()<CR>", opts)
  vim.api.nvim_buf_set_keymap(bufnr, "n", "gI", "<cmd>lua vim.lsp.buf.implementation()<CR>", opts)
  vim.api.nvim_buf_set_keymap(bufnr, "n", "gR", "<cmd>lua vim.lsp.buf.references()<CR>", opts)
  vim.api.nvim_buf_set_keymap(bufnr, "n", "!", "<cmd>lua vim.diagnostic.open_float()<CR>", opts)
  vim.cmd [[ command! Format execute 'lua vim.lsp.buf.format({ async = true })' ]]
  vim.api.nvim_buf_set_keymap(bufnr, "n", "gs", "<cmd>lua vim.lsp.buf.signature_help()<CR>", opts)
  vim.api.nvim_buf_set_keymap(bufnr, "n", "gf", "<cmd>Format<cr>", opts)
  vim.api.nvim_buf_set_keymap(bufnr, "n", "ga", "<cmd>lua vim.lsp.buf.code_action()<cr>", opts)
end

M.on_attach = function(client, bufnr)
  lsp_keymaps(bufnr)
  lsp_highlight_document(client)
  attach_navic(client, bufnr)

  if client.name == "jdt.ls" then
    -- TODO: instantiate capabilities in java file later
    M.capabilities.textDocument.completion.completionItem.snippetSupport = false
    vim.lsp.codelens.refresh()
    if JAVA_DAP_ACTIVE then
      require("jdtls").setup_dap { hotcodereplace = "auto" }
      require("jdtls.dap").setup_dap_main_class_configs()
    end
  end
end

function M.enable_format_on_save()
  vim.cmd [[
    augroup format_on_save
      autocmd! 
      autocmd BufWritePre * lua vim.lsp.buf.format({ async = true }) 
    augroup end
  ]]
  vim.notify "Enabled format on save"
end

function M.disable_format_on_save()
  M.remove_augroup "format_on_save"
  vim.notify "Disabled format on save"
end

function M.toggle_format_on_save()
  if vim.fn.exists "#format_on_save#BufWritePre" == 0 then
    M.enable_format_on_save()
  else
    M.disable_format_on_save()
  end
end

function M.remove_augroup(name)
  if vim.fn.exists("#" .. name) == 1 then
    vim.cmd("au! " .. name)
  end
end

vim.cmd [[ command! LspToggleAutoFormat execute 'lua require("user.lsp.handlers").toggle_format_on_save()' ]]

return M
