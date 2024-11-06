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
  pattern = { "lua", "javascript", "typescript", "cpp" },
  callback = function()
    vim.opt.formatoptions:remove({ "o" })
  end,
  group = general,
  desc = "Disable New Line Comment",
})

autocmd("TermOpen", {
  callback = function()
    vim.opt_local.relativenumber = false
    vim.opt_local.number = false
    vim.cmd("startinsert!")
  end,
  group = general,
  desc = "Terminal Options",
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

autocmd("FileType", {
  pattern = { "gitcommit" },
  callback = function()
    vim.opt_local.wrap = true
    vim.opt_local.spell = true
  end,
  group = general,
  desc = "Enable Wrap in these filetypes",
})
