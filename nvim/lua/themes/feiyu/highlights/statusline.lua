local colors = require("themes.feiyu.colors")

return {
  StModeNormal = {
    bg = colors.cyan,
    fg = colors.black,
  },
  StModeInsert = {
    bg = colors.green,
    fg = colors.black,
  },
  StModeVisual = {
    bg = colors.magenta,
    fg = colors.fg,
  },
  StModeReplace = {
    bg = colors.red,
    fg = colors.fg,
  },
  StModeCommand = {
    bg = colors.yellow,
    fg = colors.black,
  },
  StModeDefault = {
    bg = colors.blue,
    fg = colors.black,
  },
  StModeNormalSeparator = {
    fg = colors.cyan,
    bg = colors.fg_gutter,
  },
  StModeInsertSeparator = {
    fg = colors.green,
    bg = colors.fg_gutter,
  },
  StModeVisualSeparator = {
    fg = colors.magenta,
    bg = colors.fg_gutter,
  },
  StModeReplaceSeparator = {
    fg = colors.red,
    bg = colors.fg_gutter,
  },
  StModeCommandSeparator = {
    fg = colors.yellow,
    bg = colors.fg_gutter,
  },
  StModeTerminalSeparator = {
    fg = colors.green1,
    bg = colors.fg_gutter,
  },
  StModeDefaultSeparator = {
    fg = colors.blue,
    bg = colors.fg_gutter,
  },
  StGitIcon = {
    bg = colors.fg_gutter,
    fg = colors.orange,
  },
  StBranchName = {
    bg = colors.fg_gutter,
    fg = colors.orange,
  },
  StBranchNameSeparator = {
    fg = colors.fg_gutter,
  },
  StSectionY = {
    bg = colors.fg_gutter,
    fg = colors.orange,
  },
  StSectionYSeparator = {
    fg = colors.fg_gutter,
  },
  -- StSectionY = {
  --   bg = colors.fg_gutter,
  --   fg = colors.orange,
  -- },
  -- StSectionYSeparator = {
  --   fg = colors.fg_gutter,
  -- },
  StSeparator = {
    fg = colors.cyan,
  },
}
