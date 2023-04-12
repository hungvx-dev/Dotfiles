local opt = vim.opt -- local cmd = vim.cmd
local g = vim.g

g.mapleader = (hvim.leader == "space" and " ") or hvim.leader

opt.fillchars = { eob = " ", fold = " ", foldsep = "│", foldopen = "", foldclose = "" }
opt.list = true
opt.listchars = { tab = "» ", extends = "→", nbsp = "·", eol = "↴", trail = "·" }
opt.formatoptions = "jqlnt" -- tcqj
