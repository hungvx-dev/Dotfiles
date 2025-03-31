-- print(123)
-- local capabilities = require("blink.cmp").get_lsp_capabilities(vim.lsp.protocol.make_client_capabilities())
-- print(vim.inspect(capabilities))
-- vim.lsp.config("*", {
--   capabilities = capabilities,
--   on_attach = function(_, buffer)
--     print(vim.inspect(_))
--     print(vim.inspect(buffer))
--     --     --
--     local opts = { noremap = true, silent = true, buffer = buffer }
--
--     vim.keymap.set("n", "gd", vim.lsp.buf.definition, opts)
--     vim.keymap.set("n", "K", function()
--       vim.lsp.buf.hover({ border = "rounded" })
--     end, opts)
--     -- vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, {})
--   end,
--   root_markers = { ".git" },
-- })

-- vim.keymap.set("n", "!", vim.diagnostic.open_float)

vim.lsp.enable({
  "lua_ls",
})
