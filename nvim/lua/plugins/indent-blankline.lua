require("indent_blankline").setup {
  space_char_blankline = " ",
  -- char_highlight_list = {"IndentBlanklineIndent5", "IndentBlanklineIndent6"}
}

-- vim.g.indent_blankline_char = '┊'
-- vim.g.indent_blankline_filetype_exclude = { 'help', 'packer' }
-- vim.g.indent_blankline_show_trailing_blankline_indent = true
vim.g.indent_blankline_buftype_exclude = { 'terminal', 'nofile' }
vim.g.indent_blankline_filetype_exclude = {"help", "terminal", "dashboard", "packer"}
vim.g.indent_blankline_show_first_indent_level = false
vim.g.indentLine_enabled = 1
vim.g.indent_blankline_show_first_indent_level = false
vim.g.indent_blankline_buftype_exclude = { "terminal" }
vim.g.indent_blankline_filetype_exclude = { "help", "terminal", "dashboard" }
vim.g.indent_blankline_filetype_exclude = { "man", "help", "startify", "dashboard", "packer", "neogitstatus", "markdown" }
vim.g.indent_blankline_char = "▏"
vim.g.indent_blankline_use_treesitter = true
vim.g.indent_blankline_show_trailing_blankline_indent = false
vim.g.indent_blankline_show_current_context = true
vim.g.indent_blankline_context_patterns = {
  "class",
  "return",
  "function",
  "method",
  "^if",
  "^while",
  "^for",
  "^object",
  "^table",
  "block",
  "arguments",
  "if_statement",
  "else_clause",
  "jsx_element",
  "jsx_self_closing_element",
  "tsx_element",
  "tsx_self_closing_element",
  "try_statement",
  "catch_clause",
  "import_statement",
  "operation_type",
}
