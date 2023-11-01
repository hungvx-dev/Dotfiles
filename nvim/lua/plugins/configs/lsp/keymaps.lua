local keymap = vim.keymap
keymap.set("n", "!", vim.diagnostic.open_float)
keymap.set("n", "[d", vim.diagnostic.goto_prev)
keymap.set("n", "]d", vim.diagnostic.goto_next)
keymap.set("n", "<space>q", vim.diagnostic.setloclist)

vim.api.nvim_create_autocmd("LspAttach", {
  group = vim.api.nvim_create_augroup("UserLspConfig", {}),
  callback = function(ev)
    -- Enable completion triggered by <c-x><c-o>
    vim.bo[ev.buf].omnifunc = "v:lua.vim.lsp.omnifunc"

    -- Buffer local mappings.
    -- See `:help vim.lsp.*` for documentation on any of the below functions
    local opts = { noremap = true, silent = true, buffer = ev.buf }

    keymap.set("n", "gd", "<cmd>Telescope lsp_definitions<CR>", opts)
    keymap.set("n", "gi", "<cmd>Telescope lsp_implementations<CR>", opts)
    keymap.set("n", "gr", "<cmd>Telescope lsp_references<CR>", opts)
    keymap.set("n", "gD", vim.lsp.buf.declaration, opts)
    keymap.set("n", "<space>D", "<cmd>Telescope lsp_type_definitions<CR>", opts)
    keymap.set({ "n", "v" }, "ga", vim.lsp.buf.code_action, opts)
    keymap.set("n", "K", vim.lsp.buf.hover, opts)
    keymap.set("n", "<C-k>", vim.lsp.buf.signature_help, opts)
    keymap.set("n", "<space>rn", vim.lsp.buf.rename, opts)
    keymap.set("n", "<space>rs", ":LspRestart<CR>", opts)
    -- vim.keymap.set('n', '<space>wa', vim.lsp.buf.add_workspace_folder, opts)
    -- vim.keymap.set('n', '<space>wr', vim.lsp.buf.remove_workspace_folder, opts)
    -- vim.keymap.set('n', '<space>wl', function()
    --   print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
    -- end, opts)
  end,
})
