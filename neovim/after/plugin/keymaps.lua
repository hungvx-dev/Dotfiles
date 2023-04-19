local keymap = vim.api.nvim_set_keymap
local default_opts = { noremap = true, silent = true }
local expr_opts = { noremap = true, expr = true, silent = true }

-- Better escape using jk in insert and terminal mode
-- keymap("i", "jk", "<ESC>", default_opts)
-- keymap("t", "jk", "<C-\\><C-n>", default_opts)
-- keymap("n", "<C-h>", "<C-w>h", default_opts)
-- keymap("n", "<C-j>", "<C-w>j", default_opts)
-- keymap("n", "<C-k>", "<C-w>k", default_opts)
-- keymap("n", "<C-l>", "<C-w>l", default_opts)

-- Center search results
keymap("n", "n", "nzzzv", default_opts)
keymap("n", "N", "Nzzzv", default_opts)
keymap("n", "g,", "g,zvzz", default_opts)
keymap("n", "g;", "g;zvzz", default_opts)

-- Scrolling
keymap("n", "<C-d>", "<C-d>zz", default_opts)
keymap("n", "<C-u>", "<C-u>zz", default_opts)

-- Visual line wraps
keymap("n", "k", "v:count == 0 ? 'gk' : 'k'", expr_opts)
keymap("n", "j", "v:count == 0 ? 'gj' : 'j'", expr_opts)

-- Better indent
keymap("v", "<", "<gv", default_opts)
keymap("v", ">", ">gv", default_opts)

keymap("n", "H", "^", default_opts)
keymap("n", "L", "$", default_opts)
keymap("v", "H", "^", default_opts)
keymap("v", "L", "g_", default_opts)

-- Paste over currently selected text without yanking it
keymap("v", "p", '"_dP', default_opts)

keymap("n", "<C-q>", ":q<cr>", default_opts)
keymap("n", "<C-s>", ":w<cr>", default_opts)
keymap("i", "<C-s>", "<ESC>:w<cr>", default_opts)

keymap("n", "gt", ":bnext<cr>", default_opts)
keymap("n", "gT", ":bprevious<cr>", default_opts)

-- Switch buffer
-- keymap("n", "<S-h>", ":bprevious<CR>", default_opts)
-- keymap("n", "<S-l>", ":bnext<CR>", default_opts)

-- Cancel search highlighting with ESC
keymap("n", "<leader><CR>", ":nohlsearch<Bar>:echo<CR>", default_opts)

-- Move selected line / block of text in visual mode
keymap("x", "K", ":move '<-2<CR>gv-gv", default_opts)
keymap("x", "J", ":move '>+1<CR>gv-gv", default_opts)

-- Resizing panes
keymap("n", "<leader>=", ":vertical resize +5<CR>", default_opts)
keymap("n", "<leader>-", ":vertical resize -5<CR>", default_opts)
keymap("n", "<leader>+", ":resize -1<CR>", default_opts)
keymap("n", "<leader>_", ":resize +1<CR>", default_opts)
