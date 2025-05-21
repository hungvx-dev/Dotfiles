local colors = require("themes.feiyu.colors")

return {
  FoldColumn = {
    -- fg = colors.dark5
    fg = "#545c7e",
  },
  Folded = {
    bg = colors.none,
    -- underline = true,
    -- sp = colors.cyan
  },

  FoldClose = {
    fg = colors.cyan,
  },

  FoldVirtual = {
    -- fg = colors.blue5,
    fg = colors.blue6,
  },

  FoldText = {
    bg = colors.fg_gutter,
    fg = colors.cyan,
  },
}
