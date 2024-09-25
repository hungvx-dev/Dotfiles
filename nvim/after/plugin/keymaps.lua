local setKeyMap = vim.keymap.set

-- Better indent
setKeyMap("v", "<", "<gv")
setKeyMap("v", ">", ">gv")

setKeyMap("n", "H", "^")
setKeyMap("n", "L", "$")
setKeyMap("v", "H", "^")
setKeyMap("v", "L", "g_")

-- Paste over currently selected text without yanking it
setKeyMap("v", "p", '"_dP')

-- Cancel search highlighting with ESC
setKeyMap("n", "<leader><CR>", ":nohlsearch<Bar>:echo<CR>")

-- ReSizing panes
setKeyMap("n", "<leader>=", ":vertical resize +5<CR>")
setKeyMap("n", "<leader>-", ":vertical resize -5<CR>")
setKeyMap("n", "<leader>_", ":resize -2<CR>")
setKeyMap("n", "<leader>+", ":resize +2<CR>")

setKeyMap("n", "gT", ":bprevious<cr>")
setKeyMap("n", "gt", ":bnext<cr>")

setKeyMap("n", "<C-q>", ":q<cr>")
setKeyMap("n", "<C-s>", ":silent! w<cr>")
setKeyMap("i", "<C-s>", "<ESC>:silent! w<cr>")
