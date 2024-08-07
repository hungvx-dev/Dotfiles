local autocmd = vim.api.nvim_create_autocmd
local augroup = vim.api.nvim_create_augroup

-- General Settings
local general = augroup("General Settings", { clear = true })

-- autocmd("BufRead", {
--   callback = function()
--     vim.opt.scroll = 10
--   end,
--   group = general,
-- })

autocmd("BufEnter", {
  callback = function()
    vim.opt.formatoptions:remove({ "c", "r", "o" })
  end,
  group = general,
  desc = "Disable New Line Comment",
})

autocmd("TextYankPost", {
  callback = function()
    require("vim.highlight").on_yank({ higroup = "Visual", timeout = 300 })
  end,
  group = general,
  desc = "Highlight when yanking",
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
    vim.cmd("wincmd =")
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

autocmd("FileType", {
  pattern = { "neo-tree" },
  callback = function()
    local _, ufo = pcall(require, "ufo")
    ufo.detach()
    vim.opt_local.foldenable = false
    vim.opt_local.foldcolumn = "0"
  end,
  group = general,
  desc = "Disable neo-tree fold",
})
