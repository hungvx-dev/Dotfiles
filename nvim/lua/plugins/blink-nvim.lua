return {
  "saghen/blink.nvim",
  version = "*", -- (recommended) only required with prebuilt binaries
  build = "cargo build --release", -- for delimiters
  -- all modules handle lazy loading internally
  lazy = false,
  opts = {
    indent = {
      enabled = true,
      visible = true,
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
          "BlinkIndentViolet",
          "BlinkIndentCyan",
        },
        underline = {
          enabled = true,
          highlights = {
            "BlinkIndentRedUnderline",
            "BlinkIndentYellowUnderline",
            "BlinkIndentBlueUnderline",
            "BlinkIndentOrangeUnderline",
            "BlinkIndentGreenUnderline",
            "BlinkIndentVioletUnderline",
            "BlinkIndentCyanUnderline",
          },
        },
      },
    },
    delimiters = {
      enabled = true,
      highlights = {
        "RainbowRed",
        "RainbowYellow",
        "RainbowBlue",
        "RainbowOrange",
        "RainbowGreen",
        "RainbowViolet",
        "RainbowCyan",
      },
      priority = 200,
      ns = vim.api.nvim_create_namespace("blink.delimiters"),
      debug = false,
    },
  },
}
