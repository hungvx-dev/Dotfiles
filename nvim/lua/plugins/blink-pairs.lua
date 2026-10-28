return {
  opts = {
    mappings = {
      enabled = true,
      disabled_filetypes = {},
      pairs = {},
    },
    highlights = {
      enabled = true,
      groups = {
        'BlinkPairsRed',
        'BlinkPairsYellow',
        'BlinkPairsBlue',
        'BlinkPairsOrange',
        'BlinkPairsGreen',
        'BlinkPairsCyan',
        'BlinkPairsViolet',
      },
      -- separate = { '<' },
      matchparen = {
        enabled = true,
        cmdline = false,
        include_surrounding = false,
        group = 'MatchParen',
        priority = 250,
      },
    },
    debug = false,
  },
}
