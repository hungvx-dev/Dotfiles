local keymap = vim.api.nvim_set_keymap
local default_opts = { noremap = true, silent = true }

-- Better indent
keymap("v", "<", "<gv", default_opts)
keymap("v", ">", ">gv", default_opts)

keymap("n", "H", "^", default_opts)
keymap("n", "L", "$", default_opts)
keymap("v", "H", "^", default_opts)
keymap("v", "L", "g_", default_opts)

-- Paste over currently selected text without yanking it
keymap("v", "p", '"_dP', default_opts)

-- Cancel search highlighting with ESC
keymap("n", "<leader><CR>", ":nohlsearch<Bar>:echo<CR>", default_opts)

-- Scrolling
keymap("n", "<C-d>", "<C-d>zz", default_opts)
keymap("n", "<C-u>", "<C-u>zz", default_opts)

-- ReSizing panes
keymap("n", "<leader>=", ":vertical resize +5<CR>", default_opts)
keymap("n", "<leader>-", ":vertical resize -5<CR>", default_opts)
keymap("n", "<leader>_", ":resize -2<CR>", default_opts)
keymap("n", "<leader>+", ":resize +2<CR>", default_opts)

keymap("n", "<leader>bp", ":bprevious<cr>", default_opts)
keymap("n", "<leader>bn", ":bnext<cr>", default_opts)

keymap("n", "<C-q>", ":q<cr>", default_opts)
keymap("n", "<C-s>", ":silent! w<cr>", default_opts)
keymap("i", "<C-s>", "<ESC>:silent! w<cr>", default_opts)
