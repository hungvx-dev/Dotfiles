require("cores.default")

vim.cmd.colorscheme(HVIM.colorscheme)
vim.g.mapleader = HVIM.leader
vim.g.maplocalleader = "\\"

require("cores.lazy")
