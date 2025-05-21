return {
  "saghen/blink.pairs",
  enabled = HVIM.plugins.blink_pairs,
  version = "*", -- (recommended) only required with prebuilt binaries
  dependencies = "saghen/blink.download",
  event = { "BufReadPost", "BufNewFile" },
  -- build = "cargo build --release",
  --- @module 'blink.pairs'
  --- @type blink.pairs.Config
  opts = {
    mappings = {
      enabled = true,
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
        "BlinkPairsViolet",
        "BlinkPairsCyan",
      },
    },
    debug = false,
  },
}
