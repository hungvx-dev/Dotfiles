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
  bold_signs = {
    error = icons.Diagnostics.BoldError,
    warning = icons.Diagnostics.BoldWarning,
    warn = icons.Diagnostics.BoldWarning,
    info = icons.Diagnostics.BoldInformation,
    hint = icons.Diagnostics.BoldHint,
  },
  git_line = {
    added = icons.Git.LineAdded .. " ",
    modified = icons.Git.LineModified .. " ",
    removed = icons.Git.LineRemoved .. " ",
  },
  competitive_programming = true,
  ui = {}
}

vim.g.mapleader = HVIM.leader
vim.g.maplocalleader = "\\"
