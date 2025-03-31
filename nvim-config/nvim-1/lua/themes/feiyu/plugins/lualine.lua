local colors = require("themes.feiyu.colors")

return {
  theme = {
    normal = {
      a = { bg = colors.blue, fg = colors.fg },
      b = { bg = colors.fg_gutter, fg = colors.fg },
      c = { bg = colors.none, fg = colors.fg },
    },
    insert = {
      a = { bg = colors.green, fg = colors.black },
      b = { bg = colors.fg_gutter, fg = colors.green },
    },
    -- command = {
    --   a = { bg = colors.yellow, fg = colors.black },
    --   b = { bg = colors.fg_gutter, fg = colors.yellow },
    -- },
    visual = {
      a = { bg = colors.magenta, fg = colors.fg },
      b = { bg = colors.fg_gutter, fg = colors.magenta },
    },
    replace = {
      a = { bg = colors.red, fg = colors.fg },
      b = { bg = colors.fg_gutter, fg = colors.red },
    },
    -- terminal = {
    --   a = { bg = colors.green1, fg = colors.black },
    --   b = { bg = colors.fg_gutter, fg = colors.green1 },
    -- },
    -- inactive = {
    --   a = { bg = colors.none, fg = colors.blue },
    --   b = { bg = colors.none, fg = colors.fg, gui = "bold" },
    --   c = { bg = colors.none, fg = colors.fg },
    -- },
  },
  diff_color = {
    added = { fg = colors.git.add },
    modified = { fg = colors.git.change },
    removed = { fg = colors.git.delete },
  },
}
