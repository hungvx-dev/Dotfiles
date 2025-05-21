local colors = require("themes.feiyu.colors")

return {
  DiagnosticError = {
    fg = colors.error,
  },
  DiagnosticHint = {
    fg = colors.hint,
  },
  DiagnosticInfo = {
    fg = colors.info,
  },
  DiagnosticInformation = "DiagnosticInfo",
  DiagnosticUnderlineError = {
    sp = colors.error,
    undercurl = true,
  },
  DiagnosticUnderlineHint = {
    sp = colors.hint,
    undercurl = true,
  },
  DiagnosticUnderlineInfo = {
    sp = colors.info,
    undercurl = true,
  },
  DiagnosticUnderlineWarn = {
    sp = colors.warning,
    undercurl = true,
  },
  DiagnosticUnnecessary = {
    fg = "#8990b3",
  },
  DiagnosticWarn = {
    fg = colors.warning,
  },
  DiagnosticWarning = "DiagnosticWarn",
  -- DiagnosticVirtualTextError = {
  --   bg = "#2d202a",
  --   fg = colors.error,
  -- },
  -- DiagnosticVirtualTextHint = {
  --   bg = "#1a2b32",
  --   fg = colors.hint,
  -- },
  -- DiagnosticVirtualTextInfo = {
  --   bg = "#192b38",
  --   fg = colors.info,
  -- },
  -- DiagnosticVirtualTextWarn = {
  --   bg = "#2e2a2d",
  --   fg = colors.warning,
  -- },
}
