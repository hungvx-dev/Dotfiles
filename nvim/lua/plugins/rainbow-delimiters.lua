return {
  "hiphish/rainbow-delimiters.nvim",
  event = { "BufReadPre", "BufNewFile" },
  dependencies = { "nvim-treesitter" },
  opts = function()
    return {
      query = {
        javascript = "rainbow-parens",
        vue = "rainbow-script",
        tsx = "rainbow-parens",
        html = "rainbow-parens",
      },
    }
  end,
  config = function(_, opts)
    require("rainbow-delimiters.setup").setup(opts)
  end,
}
