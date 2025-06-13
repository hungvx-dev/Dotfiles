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
    fg = colors.dark3,
  },
  Conceal = "NonText",
  Visual = {
    bg = colors.bg_search,
  },

  IncSearch = {
    fg = colors.black,
    bg = colors.orange,
  },
  Search = {
    fg = colors.fg,
    bg = colors.bg_search,
  },

  CurSearch = "IncSearch",
  Cursor = {
    fg = colors.bg,
    bg = colors.fb,
  },
  CursorColumn = {
    bg = "#292e42",
  },
  CursorIM = "Cursor",
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

  StatusLine = base.transparent,
  StatusLineNC = base.transparent,

  -- WinBar = "Normal",
  WinBar = {
    bg = colors.bg,
    fg = colors.dark4,
    -- sp = colors.black,
    -- underline = true,
  },
  WinBarNC = "WinBar",

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
    fg = colors.blue,
  },
}
