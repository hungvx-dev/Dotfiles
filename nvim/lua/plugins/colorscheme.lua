return {
  {
    "folke/tokyonight.nvim",
    lazy     = false,
    priority = 1000,
    config   = function()
      require("plugins.configs.colorscheme.tokyonight")
      vim.cmd.colorscheme(HVIM.colorscheme)
    end,
  },
}
