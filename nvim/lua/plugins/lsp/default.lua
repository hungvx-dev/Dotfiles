local cmd = vim.cmd

local default_key = function(client, bufnr)
  require 'lsp_signature'.on_attach({auto_close_after = 3, transparency = 80, timer_interval = 100}, bufnr)
  local opts_lsp = {noremap = true, silent = true}
  vim.cmd("command! LspDe lua vim.lsp.buf.declaration()")
  vim.cmd("command! LspDef lua vim.lsp.buf.definition()")
  vim.cmd("command! LspFormatting lua vim.lsp.buf.formatting()")
  vim.cmd("command! LspCodeAction lua require('telescope.builtin').lsp_code_actions()")
  vim.cmd("command! LspHover lua vim.lsp.buf.hover()")
  vim.cmd("command! LspRename lua vim.lsp.buf.rename()")
  vim.cmd("command! LspRefs lua vim.lsp.buf.references()")
  vim.cmd("command! LspTypeDef lua vim.lsp.buf.type_definition()")
  vim.cmd("command! LspImplementation lua vim.lsp.buf.implementation()")
  vim.cmd("command! LspDiagPrev lua vim.diagnostic.goto_prev()")
  vim.cmd("command! LspDiagNext lua vim.diagnostic.goto_next()")
  vim.cmd("command! LspDiagLine lua vim.diagnostic.open_float()")
  vim.cmd("command! LspSignatureHelp lua vim.lsp.buf.signature_help()")

  vim.api.nvim_buf_set_keymap(bufnr, "n", "gD", ':LspDe<CR>', opts_lsp)
  vim.api.nvim_buf_set_keymap(bufnr, "n", "gd", ":LspDef<CR>", opts_lsp)
  vim.api.nvim_buf_set_keymap(bufnr, "n", "K", ":LspHover<CR>", opts_lsp)
  -- vim.api.nvim_buf_set_keymap(bufnr, "n", "gt", ":LspTypeDef<CR>", opts_lsp)
  vim.api.nvim_buf_set_keymap(bufnr, "n", "gR", ":LspRefs<CR>", opts_lsp)
  vim.api.nvim_buf_set_keymap(bufnr, "n", "gi", ":LspImplementation<CR>", opts_lsp)
  vim.api.nvim_buf_set_keymap(bufnr, "n", "K", ":LspHover<CR>", opts_lsp)
  vim.api.nvim_buf_set_keymap(bufnr, "n", "ga", ":LspCodeAction<CR>", opts_lsp)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', '<space>rn', ':LspRename<CR>', opts_lsp)
  -- vim.api.nvim_buf_set_keymap(bufnr, "n", 'gf', ':LspFormatting<CR>', opts_lsp)
end

return default_key
