local opts = { noremap = true, silent = true }
-- local bufopts = { noremap = true, silent = true, buffer = bufnr }
vim.keymap.set("n", "!", vim.diagnostic.open_float, opts)
vim.keymap.set("n", "[d", vim.diagnostic.goto_prev, opts)
vim.keymap.set("n", "]d", vim.diagnostic.goto_next, opts)
  vim.keymap.set("n", "gD", "cmd>Telescope lsp_declarations<CR>", opts)
vim.keymap.set("n", "gd", "<cmd>lua vim.lsp.buf.definition()<CR>", opts)
vim.keymap.set("n", "K", function()
  local winid = require("ufo").peekFoldedLinesUnderCursor()
  if not winid then
    vim.lsp.buf.hover()
  end
end, opts)
vim.keymap.set("n", "gi", "<cmd>Telescope lsp_implementations<CR>", opts)
vim.keymap.set("n", "gr", "<cmd>lua vim.lsp.buf.references({ includeDeclaration = false })<CR>", opts)
vim.keymap.set("n", "gs", vim.lsp.buf.signature_help, opts)
vim.keymap.set("n", "gf", "<cmd>lua vim.lsp.buf.format({ async = true })<CR>", opts)
vim.keymap.set("n", "ga", vim.lsp.buf.code_action, opts)

-- M.capabilities = cmp_nvim_lsp.update_capabilities(M.capabilities)

local M = {}
local function lsp_keymaps(bufnr)
  local bufopts = { noremap = true, silent = true, buffer = bufnr }
  vim.keymap.set("n", "gd", "<cmd>lua vim.lsp.buf.definition()<CR>", bufopts)
  vim.keymap.set("n", "gD", "cmd>Telescope lsp_declarations<CR>", bufopts)
  vim.keymap.set("n", "K", function()
    local winid = require("ufo").peekFoldedLinesUnderCursor()
    if not winid then
      vim.lsp.buf.hover()
    end
  end, bufopts)
  vim.keymap.set("n", "gi", "<cmd>Telescope lsp_implementations<CR>", bufopts)
  vim.keymap.set("n", "gr", "<cmd>lua vim.lsp.buf.references({ includeDeclaration = false })<CR>", bufopts)
  vim.keymap.set("n", "gs", vim.lsp.buf.signature_help, bufopts)
  vim.keymap.set("n", "gf", "<cmd>lua vim.lsp.buf.format({ async = true })<CR>", bufopts)
  vim.keymap.set("n", "ga", vim.lsp.buf.code_action, bufopts)
end

M.on_attach = function(client, bufnr)
  lsp_keymaps(bufnr)
  -- attach_navic(client, bufnr)
end
return M
