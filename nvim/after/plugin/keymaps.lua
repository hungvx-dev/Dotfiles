local setKeyMap = vim.keymap.set

-- Better indent
setKeyMap("v", "<", "<gv")
setKeyMap("v", ">", ">gv")

setKeyMap("n", "H", "^")
setKeyMap("n", "L", "g_")
setKeyMap("v", "H", "^")
setKeyMap("v", "L", "g_")

-- setKeyMap("n", "j", "v:count == 0 ? 'gj' : 'j'")
-- setKeyMap("n", "k", "v:count == 0 ? 'gk' : 'k'")

-- Paste over currently selected text without yanking it
setKeyMap("v", "p", '"_dP')

-- Cancel search highlighting with ESC
setKeyMap("n", "<leader><CR>", ":nohlsearch<Bar>:echo<CR>")

-- ReSizing panes
setKeyMap("n", "<leader>=", ":vertical resize +2<CR>")
setKeyMap("n", "<leader>-", ":vertical resize -2<CR>")
setKeyMap("n", "<leader>+", ":resize +2<CR>")
setKeyMap("n", "<leader>_", ":resize -2<CR>")

-- buffers
-- setKeyMap("n", "[b", ":bprevious<cr>")
-- setKeyMap("n", "]b", ":bnext<cr>")

setKeyMap("n", "<C-q>", ":q<cr>")
setKeyMap("n", "<C-s>", ":silent! w<cr>")
setKeyMap("i", "<C-s>", "<ESC>:silent! w<cr>")

-- setKeyMap({ "n", "v" }, ";", "<Plug>(clever-f-repeat-forward)", { remap = true })
-- setKeyMap({ "n", "v" }, ",", "<Plug>(clever-f-repeat-back)", { remap = true })
