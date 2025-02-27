local icons = require("icons")

HVIM = {
  colorscheme = "feiyu",
  leader = " ",
  use_icons = true,
  icons = icons,
  builtin = {},
  competitive_programming = false,
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
  highlight = {
    fold = true,
    indent = false,
  },
  plugins = {
    blink = true,
    lualine = true,
    statuscol = true,
    buffer = false,
    treesitter = true,
    lsp = true,
    none_ls = true,
  },
  ui = {
    colors = {
      "#fc5f66",
      "#FFEB0A",
      "#3B93F7",
      "#fb8500",
      "#ccff33",
      "#b67cff",
      "#00FFFF",
      "#f984d4",
      "#E8E2D9",
      "#a0aacc",
    },
  },
}

vim.g.mapleader = HVIM.leader
vim.g.maplocalleader = "\\"
