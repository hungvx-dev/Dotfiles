vim.o.winborder = "rounded"

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

-- #============================== 14. Folding ================================#
vim.wo.foldenable = true          -- *Unset to display all folds open
vim.wo.foldcolumn = "1"           -- Width of the column used to indicate folds
vim.wo.foldlevel = 99             -- Folds with a level higher than this number will be closed
vim.opt.foldlevelstart = 99       -- Value for 'foldlevel' when starting to edit a file
vim.o.foldmethod = "expr"         -- Folding type: "manual", "indent", "expr", "marker", "syntax" or "diff"
vim.o.foldtext = "v:lua.Custom_foldtext()"
vim.o.foldexpr = "v:lua.vim.treesitter.foldexpr()"
-- vim.o.foldexpr = 'v:lua.vim.lsp.foldexpr()'
