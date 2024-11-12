local M = {}

M.opts = {
  render = "virtual",
  virtual_symbol = "",
  virtual_symbol_suffix = " ",

  ---Set virtual symbol position()
  ---@usage 'inline'|'eol'|'eow'
  ---inline mimics VS Code style
  ---eol stands for `end of column` - Recommended to set `virtual_symbol_suffix = ''` when used.
  ---eow stands for `end of word` - Recommended to set `virtual_symbol_prefix = ' ' and virtual_symbol_suffix = ''` when used.
  virtual_symbol_position = "inline",

  ---Highlight hex colors, e.g. '#FFFFFF'
  enable_hex = true,

  ---Highlight short hex colors e.g. '#fff'
  enable_short_hex = true,

  ---Highlight rgb colors, e.g. 'rgb(1 0 0)'
  enable_rgb = true,

  ---Highlight hsl colors, e.g. 'hsl(150deg 30% 40%)'
  enable_hsl = true,

  ---Highlight CSS variables, e.g. 'var(--testing-color)'
  enable_var_usage = true,

  ---Highlight named colors, e.g. 'green'
  enable_named_colors = true,

  ---Highlight tailwind colors, e.g. 'bg-blue-500'
  enable_tailwind = true,

  ---Set custom colors
  ---Label must be properly escaped with '%' to adhere to `string.gmatch`
  --- :help string.gmatch
  -- custom_colors = {
  --   { label = "%-%-theme%-primary%-color", color = "#0f1219" },
  --   { label = "%-%-theme%-secondary%-color", color = "#5a5d64" },
  -- },

  exclude_filetypes = {},
  exclude_buftypes = {},
}

return M
