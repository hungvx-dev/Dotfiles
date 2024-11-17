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
  competitive_programming = false,
  highlight = false,
  ui = {
    colors = {
      "#fc5f66",
      "#fde64d",
      "#24aeee",
      "#ff9f49",
      "#86ef84",
      "#b67cff",
      "#4fd1c5",
      "#f984d4",
      "#E8E2D9",
      "#a0aacc",
    },
  },
}

vim.g.mapleader = HVIM.leader
vim.g.maplocalleader = "\\"
