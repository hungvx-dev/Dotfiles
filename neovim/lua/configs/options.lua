local opt = vim.opt -- local cmd = vim.cmd
local g = vim.g

g.mapleader = (hvim.leader == "space" and " ") or hvim.leader
opt.formatoptions:remove "c"
opt.formatoptions:remove "r"
opt.formatoptions:remove "o"

opt.fillchars = { eob = " ", fold = " ", foldsep = "│", foldopen = "", foldclose = "" }
