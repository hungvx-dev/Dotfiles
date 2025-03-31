local autocmd = vim.api.nvim_create_autocmd
local augroup = vim.api.nvim_create_augroup

-- General Settings
local general = augroup("General Settings", { clear = true })

-- Highlight on yank
autocmd("TextYankPost", {
  group = general,
  callback = function()
    vim.highlight.on_yank({ timeout = 300 })
  end,
  desc = "Highlight when yanking",
})

autocmd("FileType", {
  pattern = { "lua", "javascript", "typescript", "cpp", "rust" },
  callback = function()
    vim.opt.formatoptions:remove({ "o" })
  end,
  group = general,
  desc = "Disable New Line Comment",
})

autocmd("VimResized", {
  callback = function()
    local current_tab = vim.fn.tabpagenr()
    vim.cmd("wincmd =")
    vim.cmd("tabnext " .. current_tab)
  end,
  group = general,
  desc = "Equalize Splits",
})
