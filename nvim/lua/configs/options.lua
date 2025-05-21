vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

-- #================ 2. Moving around, searching and patterns =================#
vim.opt.ignorecase = true         -- Ignore case when using a search pattern
vim.opt.whichwrap:append("hl")

-- #================== 5. Syntax, highlighting and spelling ===================#
-- vim.opt.syntax = "on"
vim.opt.termguicolors = true      -- Use GUI colors for the terminal

-- #=========================== 11. Selecting text ============================#
vim.opt.clipboard = "unnamedplus" -- Synchronizes the system clipboard with Nvim's clipboard

-- #============================== 16. Mapping ================================#
vim.opt.updatetime = 300          -- Default: 1000 Update neovim screen
vim.opt.timeoutlen = 500          --	Time in milliseconds to wait for a mapped sequence to complete.

-- #=========================== 18. The swap file =============================#
vim.opt.swapfile = false
