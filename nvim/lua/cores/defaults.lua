local icons = require("icons")

return {
  colorscheme = "tokyonight",
  leader = "space",
  use_icons = true,
  icons = icons,
  builtin = {},
  signs = {
    Error = icons.Diagnostics.Error,
    Warn = icons.Diagnostics.Warning,
    Hint = icons.Diagnostics.Hint,
    Info = icons.Diagnostics.Information,
  },
}
