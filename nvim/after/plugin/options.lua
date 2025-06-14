-- #=========================== 4. Displaying text =============================#
vim.wo.wrap = true               -- Long lines wrap
vim.wo.breakindent = vim.wo.wrap         -- Preserve indentation in wrapped text
vim.wo.linebreak = vim.wo.wrap
vim.wo.number = true              -- Show the line number for each line
vim.wo.relativenumber = true      -- Show the relative line number for each line
vim.wo.numberwidth = 3            -- Number of columns to use for the line number
vim.opt.fillchars:append({
  eob = " ",
  fold = " ",
  lastline = " ",
  -- foldopen = "",
  -- foldclose = "╰",
  -- foldsep = "│",
})
vim.wo.conceallevel = 2           -- Controls whether concealable text is hidden
-- vim.wo.scroll = 10
vim.wo.smoothscroll = true
vim.opt.scrolloff = 2             -- Number of screen lines to show around the cursor
vim.opt.sidescrolloff = 8
vim.wo.list = true
vim.opt.listchars = { extends = "⟶", nbsp = " ", eol = "⏎", trail = "·" }

-- #================== 5. Syntax, highlighting and spelling ===================#
-- vim.opt.syntax = "on"
vim.opt.termguicolors = true      -- Use GUI colors for the terminal
vim.opt.cmdheight = 1             -- Number of lines used for the command-line
vim.opt.spell = false
vim.opt.spelllang = { "en_us" }
vim.opt.spelloptions = { "camel" }
vim.wo.cursorline = true          -- Highlight the screen line of the cursor
vim.wo.cursorlineopt = "number"   -- Specifies which area 'cursorline' highlights

-- #========================== 6. Multiple windows ============================#
vim.opt.splitbelow = true         -- A new window is put below the current one
vim.opt.splitright = true         -- A new window is put right of the current one
vim.opt.splitkeep = "screen"
-- vim.opt.laststatus = 3

-- #========================= 7. Multiple tab pages ===========================#
-- vim.opt.showtabline = 2           -- always show buffers/tabs

-- #========================= 10. Messages and info ===========================#
vim.opt.showmode = false
vim.opt.shortmess:append({ W = true, I = true, c = true, C = true })
-- vim.opt.shortmess:append("I")
-- vim.opt.shortmess:append("s")
-- vim.opt.shortmess:append("C")

-- #============================ 12. Editing text =============================#
-- vim.opt.pumblend = 0              -- Transparent of Popup
vim.opt.pumheight = 15            -- Maximum height of the popup menu
vim.opt.undofile = true           -- Automatically save and restore undo history

-- #========================= 13. Tabs and indenting ==========================#
vim.opt.tabstop = 2               -- *Number of spaces a <Tab> in the text stands for
vim.opt.shiftwidth = 2            -- *Number of spaces used for each step of (auto)indent
vim.opt.expandtab = true          -- *Expand <Tab> to spaces in Insert mode
vim.opt.smartindent = true        -- -Do clever autoindenting
-- vim.opt.autoindent = true         -- *Automatically set the indent of a new line
-- vim.bo.softtabstop = 2         -- -If non-zero, number of spaces to insert for a <Tab>

-- #============================== 14. Folding ================================#
vim.wo.foldenable = true          -- *Unset to display all folds open
vim.wo.foldcolumn = "1"           -- Width of the column used to indicate folds
vim.wo.foldlevel = 99             -- Folds with a level higher than this number will be closed
vim.opt.foldlevelstart = 99       -- Value for 'foldlevel' when starting to edit a file
vim.o.foldmethod = "expr"        -- Folding type: "manual", "indent", "expr", "marker", "syntax" or "diff"
vim.o.foldexpr = "v:lua.vim.treesitter.foldexpr()"
vim.o.foldtext = "v:lua.Custom_foldtext()"

-- #======================== 19. Command line editing =========================#
vim.opt.wildmode = "longest:full,full"

-- #============================== 24. various ================================#
vim.wo.signcolumn = "yes:1"       -- Always show sign column
-- vim.wo.signcolumn = "no"       -- Always show sign column
vim.opt.virtualedit = "block"     -- When to use virtual editing: "block", "insert", "all"
vim.bo.buftype = "nofile"         -- Empty, "nofile", "nowrite", "quickfix", etc.: type of buffer
vim.bo.bufhidden = "wipe"       -- What happens with a buffer when it's no longer in a window

-- vim.opt.guicursor:append(
--   "a:blinkwait701-blinkoff400-blinkon250-Cursor/lCursor,sm:block-blinkwait176-blinkoff150-blinkon175"
-- )
vim.opt.inccommand = "split"
