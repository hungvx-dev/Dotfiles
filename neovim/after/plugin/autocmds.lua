local function augroup(name)
  return vim.api.nvim_create_augroup("hung" .. name, { clear = true })
end

-- Highlight on yank
vim.api.nvim_create_autocmd("TextYankPost", {
  group = augroup "highlight_yank",
  callback = function()
    vim.highlight.on_yank()
  end,
})

-- Re size splits if window got re sized
vim.api.nvim_create_autocmd({ "VimResized" }, {
  group = augroup "resize_splits",
  callback = function()
    vim.cmd "tabdo wincmd ="
  end,
})

vim.api.nvim_create_user_command("Cppath", function()
  local path = vim.fn.expand "%"
  vim.fn.setreg("+", path)
  vim.notify('Copied "' .. path .. '" to the clipboard!')
end, {})

vim.api.nvim_create_user_command("CpRelPath", function()
  local path = vim.fn.expand "%:t"
  vim.fn.setreg("+", path)
  vim.notify('Copied "' .. path .. '" to the clipboard!')
end, {})

-- local lsp_conficts, _ = pcall(vim.api.nvim_get_autocmds, { group = "LspAttach_conflicts" })
-- if not lsp_conficts then
--   vim.api.nvim_create_augroup("LspAttach_conflicts", {})
-- end
-- vim.api.nvim_create_autocmd("LspAttach", {
--   group = "LspAttach_conflicts",
--   desc = "prevent tsserver and volar competing",
--   callback = function(args)
--     if not (args.data and args.data.client_id) then
--       return
--     end
--     local active_clients = vim.lsp.get_active_clients()
--     local client = vim.lsp.get_client_by_id(args.data.client_id)
--     -- prevent tsserver and volar competing
--     -- if client.name == "volar" or require("lspconfig").util.root_pattern("nuxt.config.ts")(vim.fn.getcwd()) then
--     -- OR
--     if client.name == "tsserver" then
--       for _, client_ in pairs(active_clients) do
--         print(client_.name)
--         -- prevent tsserver from starting if volar is already active
--         if client_.name == "volar" then
--           client.stop()
--         end
--       end
--     end
--   end,
-- })
