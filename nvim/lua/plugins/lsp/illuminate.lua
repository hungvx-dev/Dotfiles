vim.g.Illuminate_delay = 0
vim.g.Illuminate_ftblacklist = { "alpha", "NvimTree", "DressingSelect", "harpoon" }
vim.g.Illuminate_ftwhitelist = { 'vim', 'conf' }
vim.g.Illuminate_highlightUnderCursor = 0
vim.api.nvim_set_keymap("n", "<M-n>", '<cmd>lua require"illuminate".next_reference{wrap=true}<cr>', { noremap = true })
vim.api.nvim_set_keymap(
	"n",
	"<M-p",
	'<cmd>lua require"illuminate".next_reference{reverse=true,wrap=true}<cr>',
	{ noremap = true }
)