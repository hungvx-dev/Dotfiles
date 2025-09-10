local colors = require("themes.feiyu.colors")

return {
  FoldColumn = { fg = colors.slate },
  Folded = { bg = colors.none },

  FoldClose = { fg = colors.cyan },

  FoldVirtual = {
    -- fg = colors.blue5,
    fg = colors.slate,
  },

  FoldText = {
    bg = colors.slate_1,
    fg = colors.cyan,
  },
}
