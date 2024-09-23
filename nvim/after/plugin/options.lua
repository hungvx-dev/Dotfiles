local opt = vim.opt

-- #================ 2. Moving around, searching and patterns =================#
opt.ignorecase = true -- Ignore case when using a search pattern
-- opt.incsearch = true -- *Show match for partly typed search command
-- opt.smartcase = true -- *Override 'ignorecase' when pattern has upper case characters

-- #=========================== 4. Displaying text =============================#
opt.scrolloff = 999 -- Number of screen lines to show around the cursor
opt.wrap = false -- Long lines wrap
opt.number = true -- Show the line number for each line
opt.relativenumber = true -- Show the relative line number for each line
opt.numberwidth = 3 -- Number of columns to use for the line number
opt.fillchars = {
  eob = " ",
  fold = " ",
  foldsep = "│",
  foldopen = "",
  foldclose = "",
}
opt.list = true
opt.listchars = { extends = "→", nbsp = "·", eol = "↴", trail = "·", tab = "  " }

-- #================== 5. Syntax, highlighting and spelling ===================#
opt.termguicolors = true -- Use GUI colors for the terminal
opt.cursorline = true -- Highlight the screen line of the cursor
opt.cursorlineopt = "number" -- Specifies which area 'cursorline' highlights
opt.cmdheight = 0 -- Number of lines used for the command-line
opt.spell = false
opt.spelllang = { "en_us" }
opt.spelloptions = { "camel" }
-- opt.hlsearch = true -- *Highlight all matches for the last used search pattern

-- #========================== 6. Multiple windows ============================#
opt.statuscolumn = "%C%s%l" -- Custom format for the status column
opt.splitbelow = true -- A new window is put below the current one
opt.splitright = true -- A new window is put right of the current one
-- opt.hidden = true -- *Don't unload a buffer when no longer shown in a window

-- #========================= 7. Multiple tab pages ===========================#
opt.showtabline = 2 -- always show buffers/tabs

-- #========================= 10. Messages and info ===========================#
opt.shortmess:append("I")
opt.shortmess:append("s")
opt.shortmess:append("C")
-- opt.showmode = true -- *Display the current mode in the status line

-- #=========================== 11. Selecting text ============================#
opt.clipboard = "unnamedplus" -- Synchronizes the system clipboard with Nvim's clipboard

-- #============================ 12. Editing text =============================#
opt.pumblend = 0 -- Transparent of Popup
opt.pumheight = 10 -- Maximum height of the popup menu
opt.undofile = true -- Automatically save and restore undo history
-- opt.undolevels = 1000 -- *Maximum number of changes that can be undone
-- opt.showmatch = true -- *When inserting a bracket, briefly jump to its match

-- #========================= 13. Tabs and indenting ==========================#
opt.smartindent = true -- -Do clever autoindenting
opt.softtabstop = 2 -- -If non-zero, number of spaces to insert for a <Tab>
-- opt.expandtab = true -- *Expand <Tab> to spaces in Insert mode
-- opt.tabstop = 2 -- *Number of spaces a <Tab> in the text stands for
-- opt.shiftwidth = 2 -- *Number of spaces used for each step of (auto)indent
-- opt.autoindent = true -- *Automatically set the indent of a new line
-- opt.joinspaces = false -- *Use two spaces after '.' when joining a line

-- #============================== 14. Folding ================================#
-- opt.foldenable = true -- *Unset to display all folds open
opt.foldcolumn = "1" -- Width of the column used to indicate folds
opt.foldlevel = 99 -- Folds with a level higher than this number will be closed
opt.foldlevelstart = 99 -- Value for 'foldlevel' when starting to edit a file
opt.foldmethod = "expr" -- Folding type: "manual", "indent", "expr", "marker", "syntax" or "diff"
vim.opt.foldexpr = "v:lua.vim.treesitter.foldexpr()"
vim.opt.foldtext = "v:lua.Custom_foldtext()"

-- #============================== 16. Mapping ================================#
opt.updatetime = 300 -- Default: 1000 Update neovim screen
opt.timeoutlen = 500 --	Time in milliseconds to wait for a mapped sequence to complete.

-- #============================== 24. various ================================#
opt.signcolumn = "yes" -- Always show sign column
opt.virtualedit = "block" -- When to use virtual editing: "block", "insert", "all"

--
opt.guicursor:append(
  "a:blinkwait701-blinkoff400-blinkon250-Cursor/lCursor,sm:block-blinkwait176-blinkoff150-blinkon175"
)
opt.inccommand = "split"
