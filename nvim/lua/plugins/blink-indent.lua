return {
  "saghen/blink.indent",
  enabled = HVIM.plugins.blink_indent,
  event = { "BufReadPost", "BufNewFile", "BufWritePre" },
  --- @module 'blink.indent'
  --- @type blink.indent.Config
  opts = {
    blocked = {
      buftypes = { "terminal", "nofile", "prompt", "help", "quickfix" },
      filetypes = { "neo-tree", "alpha", "fzf", "help", "man", "mason", "lazy", "TelescopePrompt", "TelescopeResult", "lspinfo", "checkhealth" },
    },
    mappings = {
      border = "none",
      object_scope = "",
      object_scope_with_border = "",
      goto_top = "",
      goto_bottom = "",
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
      priority = 1000,
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
  },
}
