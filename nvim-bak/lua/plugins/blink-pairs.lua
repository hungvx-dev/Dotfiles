return {
  "saghen/blink.pairs",
  enabled = HVIM.plugins.blink_pairs,
  version = "*",
  dependencies = "saghen/blink.download",
  -- build = "cargo build --release",
  event = { "BufReadPost", "BufNewFile", "BufWritePre" },
  --- @module 'blink.pairs'
  ---@diagnostic disable-next-line: undefined-doc-name
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
        "BlinkPairsRed",
        "BlinkPairsYellow",
        "BlinkPairsBlue",
        "BlinkPairsOrange",
        "BlinkPairsGreen",
        "BlinkPairsCyan",
        "BlinkPairsViolet",
      },
      matchparen = {
        enabled = true,
        cmdline = false,
        group = "MatchParen",
      },
    },
    debug = false,
  },
}
