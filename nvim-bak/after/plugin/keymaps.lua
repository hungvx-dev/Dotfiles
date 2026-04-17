local setKeyMap = vim.keymap.set
local slient = { silent = true }

-- Better indent
setKeyMap("v", "<", "<gv")
setKeyMap("v", ">", ">gv")

setKeyMap("n", "H", "^")
setKeyMap("n", "L", "$")
setKeyMap("v", "H", "^")
setKeyMap("v", "L", "$")

-- setKeyMap("n", "j", "v:count == 0 ? 'gj' : 'j'", { expr = true, silent = true })
-- setKeyMap("n", "k", "v:count == 0 ? 'gk' : 'k'", { expr = true, silent = true })

-- Paste over currently selected text without yanking it
setKeyMap("v", "p", '"_dP')

-- Cancel search highlighting with ESC
setKeyMap("n", "<leader><CR>", ":nohlsearch<Bar>:echo<CR>")

-- ReSizing panes
setKeyMap("n", "<leader>=", ":vertical resize +4<CR>", slient)
setKeyMap("n", "<leader>-", ":vertical resize -4<CR>", slient)
setKeyMap("n", "<leader>+", ":resize +4<CR>", slient)
setKeyMap("n", "<leader>_", ":resize -4<CR>", slient)

-- buffers
-- setKeyMap("n", "[b", ":bprevious<cr>")
-- setKeyMap("n", "]b", ":bnext<cr>")

setKeyMap("n", "<C-q>", ":q<cr>", slient)
setKeyMap("n", "<C-s>", ":w<cr>", slient)
setKeyMap("i", "<C-s>", "<ESC>:w<cr>", slient)

setKeyMap({ "n", "v" }, "<C-d>", "10j")
setKeyMap({ "n", "v" }, "<C-u>", "10k")

-- setKeyMap({ "n", "v" }, ";", "<Plug>(clever-f-repeat-forward)", { remap = true })
-- setKeyMap({ "n", "v" }, ",", "<Plug>(clever-f-repeat-back)", { remap = true })
