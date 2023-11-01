HVIM = vim.deepcopy(require("cores.defaults"))
vim.g.mapleader = (HVIM.leader == "space" and " ") or HVIM.leader
require("cores.lazy")
