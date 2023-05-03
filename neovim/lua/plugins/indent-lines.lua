local M = {}

local opts = {
  enabled = true,
  buftype_exclude = { "terminal", "nofile" },
  filetype_exclude = {
    "help",
    "startify",
    "dashboard",
    "lazy",
    "NvimTree",
    "Trouble",
    "neo-tree",
    "alpha",
    "mason"
  },
  char = hvim.icons.ui.LineLeft,
  context_char = hvim.icons.ui.LineLeft,
  show_trailing_blankline_indent = true,
  show_first_indent_level = true,
  use_treesitter = true,
  show_current_context = true,
  show_current_context_start = true,
  context_patterns = {
    "class",
    "return",
    "function",
    "method",
    "^if",
    "^while",
    "jsx_element",
    "^for",
    "^object",
    "^table",
    "block",
    "arguments",
    "if_statement",
    "else_clause",
    "jsx_element",
    "jsx_self_closing_element",
    "try_statement",
    "catch_clause",
    "import_statement",
    "operation_type",
  },
}

M.setup = function()
  local status_ok, indent_blankline = pcall(require, "indent_blankline")
  if not status_ok then
    return
  end

  indent_blankline.setup(opts)
end

return M
