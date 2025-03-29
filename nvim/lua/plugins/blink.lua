return {
  "saghen/blink.nvim",
  enabled = HVIM.plugins.blink_nvim,
  build = "cargo build --release", -- for delimiters
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
    -- tree = { enabled = true },
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
  -- keys = {
  --   -- chartoggle
  --   {
  --     ";",
  --     function()
  --       require("blink.chartoggle").toggle_char_eol(";")
  --     end,
  --     mode = { "n", "v" },
  --     desc = "Toggle ; at eol",
  --   },
  --   {
  --     ",",
  --     function()
  --       require("blink.chartoggle").toggle_char_eol(",")
  --     end,
  --     mode = { "n", "v" },
  --     desc = "Toggle , at eol",
  --   },
  --
  --   -- tree
  --   { "<C-e>", "<cmd>BlinkTree reveal<cr>", desc = "Reveal current file in tree" },
  --   { "<leader>E", "<cmd>BlinkTree toggle<cr>", desc = "Reveal current file in tree" },
  --   { "<leader>e", "<cmd>BlinkTree toggle-focus<cr>", desc = "Toggle file tree focus" },
  -- },
}
