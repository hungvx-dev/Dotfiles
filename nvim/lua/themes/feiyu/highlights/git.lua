local colors = require("themes.feiyu.colors")

return {
  ["@diff.delta"] = "DiffChange",
  ["@diff.minus"] = "DiffDelete",
  ["@diff.plus"] = "DiffAdd",
  DiffAdd = {
    bg = colors.diff.add,
  },
  DiffChange = {
    bg = colors.diff.change,
  },
  DiffDelete = {
    bg = colors.diff.delete,
  },
  DiffText = {
    bg = colors.diff.text,
  },
  GitSignsAdd = {
    fg = colors.git.add,
  },
  GitSignsChange = {
    fg = colors.git.change,
  },
  GitSignsDelete = {
    fg = colors.git.delete,
  },
  SLGitIcon = {
    bg = colors.fg_gutter,
    fg = colors.orange,
  },
  SLBranchName = {
    bg = colors.fg_gutter,
    fg = colors.orange,
  },
}
