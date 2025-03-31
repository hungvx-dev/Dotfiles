vim.api.nvim_create_autocmd("FileType", {
  pattern = { "qf", "help", "netrw", "terminal", "scratch", "diffthis" },
  callback = function()
    vim.bo.buftype = "nofile"
    vim.bo.bufhidden = "wipe"
  end,
})
