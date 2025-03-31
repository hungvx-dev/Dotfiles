local base = require("themes.feiyu.base")
local colors = require("themes.feiyu.colors")

return {
  Normal = base.default,
  NormalFloat = base.default,
  NormalNC = base.default,
  NormalSB = base.default,

  Pmenu = base.default,
  PmenuMatch = base.cursor,
  PmenuMatchSel = base.cursor,
  PmenuSbar = base.transparent,
  PmenuSel = {
    bg = colors.bg,
    sp = colors.cyan,
    underline = true,
  },
  PmenuThumb = {
    bg = colors.cyan,
  },

  FloatShadow = base.transparent,
  FloatShadowThrough = base.transparent,
  FloatBorder = base.cursor,
  FloatTitle = base.cursor,

  NonText = {
    fg = colors.dark3
  },
  Visual = {
    bg = colors.bg_search,
  },

  IncSearch = {
    bg = colors.orange,
    fg = colors.black,
  },
  Search = {
    bg = colors.bg_search,
    fg = colors.fg,
  },

  CurSearch = {
    bg = colors.orange,
    fg = colors.black,
  },
  Cursor = {
    bg = colors.fb,
    fg = colors.bg,
  },
  CursorColumn = {
    bg = "#292e42",
  },
  CursorIM = {
    bg = colors.fb,
    fg = colors.bg,
  },
  CursorLine = {
    bg = colors.bg,
    sp = colors.cyan,
    underline = true,
  },
  CursorLineNr = {
    bold = true,
    fg = colors.cyan,
  },

  LineNrAbove = {
    fg = colors.dark5,
  },
  LineNrBelow = {
    fg = colors.dark5,
  },

  WinSeparator = {
    -- bold = true,
    fg = colors.black,
  },

  MatchParen = {
    bold = true,
    fg = colors.none,
    bg = colors.bg_search,
  },

  TabLineSel = {
    bg = colors.none,
    fg = colors.cyan,
  },

  Directory = {
    fg = "#74a2ff",
  },

  Folded = {
    bg = colors.bg_search,
    fg = colors.cyan,
  },
}
