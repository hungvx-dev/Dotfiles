local tokyonight = require("plugins.configs.colorscheme.tokyo.tokyonight")
-- local nightfox = require("plugins.configs.colorscheme.nightfox.nightfox")

return {
  {
    "folke/tokyonight.nvim",
    enabled = true,
    lazy = false,
    priority = 1000,
    opts = tokyonight.opts,
  },
  {
    "EdenEast/nightfox.nvim",
    enabled = false,
    lazy = false,
    priority = 1000,
    init = function()
      -- HVIM.colorscheme = "Nightfox"
      -- HVIM.colorscheme = "Terafox"
      -- HVIM.colorscheme = "Nordfox"
      -- HVIM.colorscheme = "Duskfox"
    end,
    opts = {
      transparent = true,
      palettes = {
        all = {
          bg1 = "#000000", -- Black background
          bg0 = "#000000", -- Alt backgrounds (floats, statusline, ...)
          bg3 = "#121820", -- 55% darkened from stock
          sel0 = "#000000", -- 55% darkened from stock
        },
      },
    },
  },
  {
    "rose-pine/neovim",
    name = "rose-pine",
    enabled = false,
    lazy = false,
    init = function()
      HVIM.colorscheme = "rose-pine"
    end,
    opts = {
      dark_variant = "main", -- main, moon, dawn
      styles = {
        bold = true,
        italic = true,
        transparency = true,
      },
    },
  },
}
