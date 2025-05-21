return {
  {
    "echasnovski/mini.pairs",
    enabled = not HVIM.plugins.blink_pairs,
    version = false,
    event = { "BufReadPost", "BufNewFile" },
    opts = {},
  },
  {
    "hiphish/rainbow-delimiters.nvim",
    enabled = not HVIM.plugins.blink_pairs,
    event = { "BufReadPost" },
    dependencies = { "nvim-treesitter" },
    opts = {
      query = {
        javascript = "rainbow-parens",
        tsx = "rainbow-parens",
        -- vue = "rainbow-script",
      },
    },
    config = function(_, opts)
      require("rainbow-delimiters.setup").setup(opts)
    end,
  },
}
