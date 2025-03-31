local colors = require("themes.feiyu.colors")

return {
  NeoTreeDimText = {
    fg = colors.cyan,
  },
  NeoTreeFileName = {
    fg = colors.fg,
  },
  NeoTreeGitModified = {
    fg = colors.orange,
  },
  NeoTreeGitStaged = {
    fg = colors.green1,
  },
  NeoTreeGitUntracked = {
    fg = "#bb9af7",
  },
  NeoTreeNormal = {
    bg = colors.bg,
    fg = colors.fg,
  },
  NeoTreeNormalNC = {
    bg = colors.bg,
    fg = colors.fg,
  },
  NeoTreeTabActive = {
    bold = true,
    bg = colors.bg,
    fg = colors.blue,
  },
  NeoTreeTabInactive = {
    bg = colors.bg,
    fg = colors.dark3,
  },
  NeoTreeTabSeparatorActive = {
    bg = colors.bg,
    fg = colors.blue,
  },
  NeoTreeTabSeparatorInactive = {
    bg = colors.bg,
    fg = colors.black,
  },
  NeoTreeCursorLine = {
    bg = colors.bg,
    sp = colors.cyan,
    underline = true,
  },
  NeoTreeWinSeparator = {
    fg = colors.cyan,
  },
}
