-- stylua: ignore
local opt = vim.opt -- local cmd = vim.cmd

-- Remap leader and local leader to <Space>
vim.keymap.set("", "<Space>", "<Nop>", { noremap = true, silent = true })

opt.syntax = "on"
opt.mouse = "a" --Enable mouse mode
opt.encoding = "utf-8"
opt.fileencoding = "utf-8"
opt.termguicolors = true -- Enable colors in terminal
opt.clipboard = "unnamedplus" -- Access system clipboard

opt.showmode = true
opt.showmatch = true

-- Tab
opt.expandtab = true -- Replace tab with space
opt.softtabstop = 2 -- Tab size, with expandtab = true
opt.tabstop = 2 -- Tab size, with expandtab = false
-- opt.smarttab = true -- Other tab of expandtab

-- Indent
opt.smartindent = true --Smart indent by language
opt.autoindent = true -- Auto indent by before line
opt.shiftwidth = 2 -- Indent size
opt.joinspaces = false -- No double spaces with join after a dot
-- opt.wrap = false
-- opt.breakindent = true --Enable break indent

-- Fold
opt.foldcolumn = "1"
opt.foldenable = true
opt.foldlevel = 99
opt.foldlevelstart = 99
-- opt.foldmethod = "expr"
-- opt.foldexpr = "nvim_treesitter#foldexpr()"

-- Undo/ReUndo
opt.undofile = true --Save undo history
opt.undolevels = 10000

-- Spell check
opt.spell = false
opt.spelllang = { "en_us" }
opt.spelloptions = { "camel" }

-- Search
opt.ignorecase = true -- Ignore uppercase when searching
opt.smartcase = true -- Smart case
opt.hlsearch = true --Set highlight on search
opt.incsearch = true

-- Scroll
opt.scrolloff = 5 -- Lines of context
-- opt.scroll = 10 -- C-d / C-u scroll

-- Timing
opt.updatetime = 300 -- Default: 1000 Update neovim screen
opt.timeoutlen = 500 --	Time in milliseconds to wait for a mapped sequence to complete.

-- SignColumn
opt.signcolumn = "yes" -- Always show sign column
opt.statuscolumn = "%C%s%l"
opt.number = true --Make line numbers default
-- opt.relativenumber = true --Make relative number default
opt.numberwidth = 4 -- Number of characters for view column number
opt.cursorline = true -- Enable highlighting of the current line
opt.culopt = "number" -- Enable highlighting of the current line
-- opt.colorcolumn = "80"
-- opt.ruler = true

-- Popup
opt.pumblend = 0 -- Transparent of Popup
opt.pumheight = 10 -- Maximum number of entries in a Popup

-- Split
opt.splitbelow = true
opt.splitright = true

-- Wild
-- opt.wildignorecase = true
-- opt.wildignore:append("**/node_modules/*")
-- opt.wildignore:append("**/.git/*")

-- Format Options
-- opt.formatoptions:remove("t")
-- opt.formatoptions:remove("r")
-- opt.formatoptions:remove("o")
-- opt.formatoptions:remove("r")
-- opt.formatoptions:remove("j")
-- opt.formatoptions:remove("q")

-- Mix
opt.showtabline = 2 -- always show buffers/tabs
opt.conceallevel = 0 -- so that `` is visible in markdown files
opt.cmdheight = 0 -- Height of command
opt.swapfile = false
opt.hidden = true
vim.g.markdown_recommended_style = "gfm"
opt.shortmess:append("I")
opt.shortmess:append("s")
opt.shortmess:append("C")
-- opt.textwidth = 0

opt.list = true
opt.listchars = { extends = "→", nbsp = "·", eol = "↴", trail = "·" }
opt.backspace = "indent,eol,start"

opt.fillchars = {
  eob = " ",
  fold = " ",
  foldsep = "│",
  foldopen = "",
  foldclose = "",
}

-- Better search
-- opt.path:remove "/usr/include"
-- opt.path:append "**"
