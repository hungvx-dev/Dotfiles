local keymap = vim.keymap
keymap.set("n", "!", vim.diagnostic.open_float)
keymap.set("n", "[d", vim.diagnostic.goto_prev)
keymap.set("n", "]d", vim.diagnostic.goto_next)
keymap.set("n", "<space>q", vim.diagnostic.setloclist)
keymap.set("n", "<space>rs", ":LspRestart<CR>", { noremap = true, silent = true })

vim.api.nvim_create_autocmd("LspAttach", {
  callback = function(ev)
    local opts = { noremap = true, silent = true, buffer = ev.buf }

    -- keymap.set("n", "gf", function()
    --   vim.lsp.buf.format({
    --     filter = function(client)
    --       return client.name == "null-ls"
    --     end,
    --     bufnr = ev.buf,
    --   })
    -- end, opts)

    keymap.set("n", "gf", function()
      vim.lsp.buf.format({ async = true })
    end, opts)
    -- keymap.set("n", "gd", "<cmd>Telescope lsp_definitions<CR>", opts)
    -- keymap.set("n", "gd", vim.lsp.buf.definition, opts)
    keymap.set("n", "gd", function()
      require("telescope.builtin").lsp_definitions({ reuse_win = true })
    end, opts)
    keymap.set("n", "gi", "<cmd>Telescope lsp_implementations<CR>", opts)
    keymap.set("n", "gr", "<cmd>Telescope lsp_references<CR>", opts)
    keymap.set("n", "gt", "<cmd>Telescope lsp_type_definitions<CR>", opts)
    keymap.set("n", "gR", vim.lsp.buf.rename, opts)
    keymap.set("n", "gD", vim.lsp.buf.declaration, opts)
    keymap.set({ "n", "v" }, "ga", vim.lsp.buf.code_action, opts)
    keymap.set("n", "K", vim.lsp.buf.hover, opts)
    keymap.set("n", "gK", vim.lsp.buf.signature_help, opts)
    -- keymap.set("n", "gd", vim.lsp.buf.definition, opts)
  end,
})
