return {
  {
    "saghen/blink.pairs",
    enabled = HVIM.plugins.blink_pairs,
    version = "*", -- (recommended) only required with prebuilt binaries
    dependencies = "saghen/blink.download",
    event = { "BufReadPost", "BufNewFile", "BufWritePre" },
    --- @module 'blink.pairs'
    --- @type blink.pairs.Config
    opts = {
      mappings = {
        enabled = true,
        -- you may also disable with `vim.g.pairs = false` (global) or `vim.b.pairs = false` (per-buffer)
        disabled_filetypes = {},
        pairs = {},
      },
      highlights = {
        enabled = true,
        groups = {
          "BlinkPairsOrange",
          "BlinkPairsViolet",
          "BlinkPairsBlue",
          "BlinkPairsRed",
          "BlinkPairsCyan",
          "BlinkPairsYellow",
          "BlinkPairsGreen",
        },
        matchparen = {
          enabled = true,
          group = "MatchParen",
        },
      },
      debug = false,
    },
  },
  {
    "echasnovski/mini.pairs",
    enabled = not HVIM.plugins.blink_pairs,
    version = false,
    event = { "BufReadPost", "BufNewFile" },
    opts = {},
  },
}
