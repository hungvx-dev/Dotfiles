vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1
-- #================ 2. Moving around, searching and patterns =================#
vim.opt.ignorecase = true -- Ignore case when using a search pattern
vim.opt.whichwrap:append("hl")

-- #=========================== 4. Displaying text =============================#
vim.wo.wrap = true -- Long lines wrap
vim.wo.breakindent = true -- Preserve indentation in wrapped text
vim.wo.linebreak = true
vim.wo.number = true -- Show the line number for each line
vim.wo.relativenumber = true -- Show the relative line number for each line
vim.wo.numberwidth = 3 -- Number of columns to use for the line number
vim.opt.fillchars = {
  eob = " ",
  fold = " ",
  foldsep = "│",
  foldopen = "󰅀",
  foldclose = "󰅂",
}
vim.wo.conceallevel = 2 -- Controls whether concealable text is hidden
vim.wo.scroll = 10
vim.wo.smoothscroll = true
vim.opt.scrolloff = 10 -- Number of screen lines to show around the cursor
vim.wo.list = true
vim.opt.listchars = { extends = "→", nbsp = " ", eol = "↴", trail = "·", tab = "  ", space = " " }

-- #================== 5. Syntax, highlighting and spelling ===================#
vim.opt.syntax = "on"
vim.opt.termguicolors = true -- Use GUI colors for the terminal
vim.opt.cmdheight = 0 -- Number of lines used for the command-line
vim.opt.spell = false
vim.opt.spelllang = { "en_us" }
vim.opt.spelloptions = { "camel" }
vim.wo.cursorline = true -- Highlight the screen line of the cursor
vim.wo.cursorlineopt = "number" -- Specifies which area 'cursorline' highlights

-- #========================== 6. Multiple windows ============================#
vim.opt.splitbelow = true -- A new window is put below the current one
vim.opt.splitright = true -- A new window is put right of the current one
vim.wo.statuscolumn = "%C%s%l" -- Custom format for the status column

-- #========================= 7. Multiple tab pages ===========================#
vim.opt.showtabline = 2 -- always show buffers/tabs

-- #========================= 10. Messages and info ===========================#
vim.opt.shortmess:append("I")
vim.opt.shortmess:append("s")
vim.opt.shortmess:append("C")

-- #=========================== 11. Selecting text ============================#
vim.opt.clipboard = "unnamedplus" -- Synchronizes the system clipboard with Nvim's clipboard

-- #============================ 12. Editing text =============================#
vim.opt.pumblend = 0 -- Transparent of Popup
vim.opt.pumheight = 10 -- Maximum height of the popup menu
vim.opt.undofile = true -- Automatically save and restore undo history

-- #========================= 13. Tabs and indenting ==========================#
vim.opt.tabstop = 2 -- *Number of spaces a <Tab> in the text stands for
vim.opt.shiftwidth = 2 -- *Number of spaces used for each step of (auto)indent
vim.opt.expandtab = true -- *Expand <Tab> to spaces in Insert mode
vim.opt.smartindent = true -- -Do clever autoindenting
vim.opt.autoindent = true -- *Automatically set the indent of a new line
-- vim.bo.softtabstop = 2 -- -If non-zero, number of spaces to insert for a <Tab>

-- #============================== 14. Folding ================================#
-- opt.foldenable = true -- *Unset to display all folds open
vim.wo.foldcolumn = "1" -- Width of the column used to indicate folds
vim.wo.foldlevel = 99 -- Folds with a level higher than this number will be closed
vim.opt.foldlevelstart = 99 -- Value for 'foldlevel' when starting to edit a file
vim.wo.foldmethod = "expr" -- Folding type: "manual", "indent", "expr", "marker", "syntax" or "diff"
vim.wo.foldexpr = "v:lua.vim.treesitter.foldexpr()"
vim.wo.foldtext = "v:lua.Custom_foldtext()"

-- #============================== 16. Mapping ================================#
vim.opt.updatetime = 300 -- Default: 1000 Update neovim screen
vim.opt.timeoutlen = 500 --	Time in milliseconds to wait for a mapped sequence to complete.

-- #============================== 18. The swap file ================================#
vim.opt.swapfile = false

-- #============================== 24. various ================================#
vim.wo.signcolumn = "yes" -- Always show sign column
vim.opt.virtualedit = "block" -- When to use virtual editing: "block", "insert", "all"

--
vim.opt.guicursor:append(
  "a:blinkwait701-blinkoff400-blinkon250-Cursor/lCursor,sm:block-blinkwait176-blinkoff150-blinkon175"
)
vim.opt.inccommand = "split"
