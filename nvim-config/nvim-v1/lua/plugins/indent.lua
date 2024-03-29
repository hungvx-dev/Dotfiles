-- https://github.com/lukas-reineke/indent-blankline.nvim
local status_ok, indent_blankline = pcall(require, "indent_blankline")
if not status_ok then
  return
end

-- vim.opt.listchars:append("space:⋅")
-- vim.opt.listchars:append("eol:↴")

indent_blankline.setup {
  buftype_exclude = {"terminal", "telescope", "nofile"},
  filetype_exclude = {"man","terminal", "startify", "neogitstatus", "help", "dashboard", "packer", "NvimTree", "Trouble", "TelescopePrompt", "Float"},
  -- char = "▏",
  show_current_context = true,
  show_current_context_start = false,
  show_end_of_line = false,
  show_first_indent_level = true,
  show_trailing_blankline_indent = true,
  space_char_blankline = " ",
  use_treesitter = true,
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
  }
}
