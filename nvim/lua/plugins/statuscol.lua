return {
  "statuscol",
  dev = true,
  enabled = HVIM.plugins.statuscol,
  event = { "BufWinEnter" },
  -- event = "VeryLazy",
  opts = {
    ft_ignore = { "neo-tree", "alpha", "lazy", "help" },
    -- wrap = { "markdown" },
  },
}
