-- local api = vim.api
--
local g = vim.g
local opt = vim.opt -- local cmd = vim.cmd
-- Remap leader and local leader to <Space>
-- api.nvim_set_keymap("", "<Space>", "<Nop>", { noremap = true, silent = true })
vim.keymap.set("", "<Space>", "<Nop>", { noremap = true, silent = true })
g.vimsyn_embed = "lPr" -- Syntax embedding for Lua, Python and Ruby

opt.termguicolors = true -- Enable colors in terminal
opt.completeopt = "menu,menuone,noselect"
opt.cursorline = true -- Enable highlighting of the current line
opt.hlsearch = true --Set highlight on search
opt.number = true --Make line numbers default
opt.relativenumber = true --Make relative number default
opt.mouse = "a" --Enable mouse mode
opt.breakindent = true --Enable break indent
opt.undofile = true --Save undo history
opt.undolevels = 10000
opt.ignorecase = true --Case insensitive searching unless /C or capital in search
opt.smartcase = true -- Smart case
opt.updatetime = 400 --Decrease update time
opt.signcolumn = "yes" -- Always show sign column
opt.clipboard = "unnamedplus" -- Access system clipboard
opt.timeoutlen = 1000 --	Time in milliseconds to wait for a mapped sequence to complete.
opt.showmode = false -- Do not need to show the mode. We use the statusline instead.
opt.scrolloff = 8 -- Lines of context
-- opt.scrolloff = 999 -- Lines of context
-- opt.sidescrolloff = 999
opt.joinspaces = false -- No double spaces with join after a dot
opt.sessionoptions = "buffers,curdir,help,tabpages,winsize,winpos,terminal"
opt.smartindent = true --Smart indent
opt.expandtab = true
opt.smarttab = true
opt.textwidth = 0
opt.autoindent = true
opt.shiftwidth = 2
opt.tabstop = 2
opt.pumblend = 10 -- Popup blend
opt.pumheight = 10 -- Maximum number of entries in a popup
opt.spelllang = { "en" }
opt.softtabstop = 2
opt.splitbelow = true
opt.splitright = true
opt.laststatus = 3 -- Global statusline
opt.cmdheight = 1 -- 0
-- opt.scroll = 10
-- opt.scrollback = 100000
opt.hidden = true
-- opt.formatoptions = "jcroqlnt" -- tcqj
-- Change to use lualine.nvim
-- opt.winbar = "%{%v:lua.require'config.winbar'.get_winbar()%}"

-- go to previous/next line with h,l,left arrow and right arrow when cursor reaches end/beginning of line
opt.whichwrap:append "<>[]hl"

-- disable nvim intro
opt.shortmess:append "sI"

-- Better search
opt.path:remove "/usr/include"
opt.path:append "**"
-- vim.cmd [[set path=.,,,$PWD/**]] -- Set the path directly

opt.wildignorecase = true
opt.wildignore:append "**/node_modules/*"
opt.wildignore:append "**/.git/*"

opt.foldcolumn = "0"
opt.foldenable = true
opt.foldlevel = 99
opt.foldlevelstart = 99
-- opt.foldmethod = "expr"
-- opt.foldexpr = "nvim_treesitter#foldexpr()"

opt.list = true
opt.listchars:append "tab:» "
opt.listchars:append "extends:→"
opt.listchars:append "nbsp:·"
opt.listchars:append "eol:↴"
opt.listchars:append "trail:·"

if g.neovide then
  g.neovide_transparency = 0.9
  g.neovide_fullscreen = true
end

if vim.fn.has "nvim-0.9.0" == 1 then
  opt.splitkeep = "screen"
  opt.shortmess:append { C = true }
end

-- Fix markdown indentation settings
vim.g.markdown_recommended_style = 0

-- Load filetype.lua
g.do_filetype_lua = 1
g.did_load_filetypes = 0