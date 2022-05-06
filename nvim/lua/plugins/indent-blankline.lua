require("indent_blankline").setup {space_char_blankline = " ", char_highlight_list = {"IndentBlanklineIndent5", "IndentBlanklineIndent6"}}

vim.g.indent_blankline_char = '┊'
vim.g.indent_blankline_filetype_exclude = { 'help', 'packer' }
vim.g.indent_blankline_show_trailing_blankline_indent = false
vim.g.indent_blankline_buftype_exclude = { 'terminal', 'nofile' }
