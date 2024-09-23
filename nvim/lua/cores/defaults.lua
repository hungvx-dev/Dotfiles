local icons = require("icons")

HVIM = {
  colorscheme = "tokyonight",
  leader = " ",
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

vim.g.mapleader = HVIM.leader
vim.g.maplocalleader = "\\"
