local colors = require("themes.feiyu.colors")

return {
  indent = {
    RainbowRed = {
      fg = colors.red,
    },
    RainbowYellow = {
      fg = colors.yellow,
    },
    RainbowBlue = {
      fg = colors.blue,
    },
    RainbowOrange = {
      fg = colors.orange,
    },
    RainbowGreen = {
      fg = colors.green,
    },
    RainbowViolet = {
      fg = colors.purple,
    },
    RainbowCyan = {
      fg = colors.cyan,
    },
  },
  blink = {
    indent = {
      BlinkIndentRed = "RainbowRed",
      BlinkIndentYellow = "RainbowYellow",
      BlinkIndentBlue = "RainbowBlue",
      BlinkIndentOrange = "RainbowOrange",
      BlinkIndentGreen = "RainbowGreen",
      BlinkIndentViolet = "RainbowViolet",
      BlinkIndentCyan = "RainbowCyan",
    },
    pairs = {
      BlinkPairsRed = "RainbowRed",
      BlinkPairsYellow = "RainbowYellow",
      BlinkPairsBlue = "RainbowBlue",
      BlinkPairsOrange = "RainbowOrange",
      BlinkPairsGreen = "RainbowGreen",
      BlinkPairsViolet = "RainbowViolet",
      BlinkPairsCyan = "RainbowCyan",
    },
    underline = {
      BlinkIndentRedUnderline = {
        sp = colors.red,
        underline = true,
      },
      BlinkIndentYellowUnderline = {
        sp = colors.yellow,
        underline = true,
      },
      BlinkIndentBlueUnderline = {
        sp = colors.blue,
        underline = true,
      },
      BlinkIndentOrangeUnderline = {
        sp = colors.orange,
        underline = true,
      },
      BlinkIndentGreenUnderline = {
        sp = colors.green,
        underline = true,
      },
      BlinkIndentVioletUnderline = {
        sp = colors.purple,
        underline = true,
      },
      BlinkIndentCyanUnderline = {
        sp = colors.cyan,
        underline = true,
      },
    },
  },
  fold = {
    Folded = {
      bg = colors.bg_search,
      fg = colors.cyan,
    },
    FoldLevel_1 = "RainbowRed",
    FoldLevel_2 = "RainbowYellow",
    FoldLevel_3 = "RainbowBlue",
    FoldLevel_4 = "RainbowOrange",
    FoldLevel_5 = "RainbowGreen",
    FoldLevel_6 = "RainbowViolet",
    FoldLevel_7 = "RainbowCyan",
  },
}
