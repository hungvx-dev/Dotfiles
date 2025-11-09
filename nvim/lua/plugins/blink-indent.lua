return {
  "saghen/blink.indent",
  enabled = HVIM.plugins.blink_indent,
  event = { "BufReadPost", "BufNewFile", "BufWritePre" },
  opts = {
    blocked = {
      buftypes = { "terminal", "nofile", "prompt", "help", "quickfix" },
      filetypes = { "neo-tree", "alpha", "fzf", "help", "man", "mason", "lazy", "TelescopePrompt", "TelescopeResult", "lspinfo" },
    },
    static = {
      enabled = true,
      char = HVIM.icons.UI.Line.Left,
      priority = 1,
      highlights = { "BlinkIndent" },
    },
    scope = {
      enabled = true,
      char = HVIM.icons.UI.Line.Left,
      priority = 1024,
      highlights = {
        "BlinkIndentRed",
        "BlinkIndentYellow",
        "BlinkIndentBlue",
        "BlinkIndentOrange",
        "BlinkIndentGreen",
        "BlinkIndentCyan",
        "BlinkIndentViolet",
      },
      underline = {
        enabled = true,
        highlights = {
          "BlinkIndentRedUnderline",
          "BlinkIndentYellowUnderline",
          "BlinkIndentBlueUnderline",
          "BlinkIndentOrangeUnderline",
          "BlinkIndentGreenUnderline",
          "BlinkIndentCyanUnderline",
          "BlinkIndentVioletUnderline",
        },
      },
    },
    visible = true,
  },
}
