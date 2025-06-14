return {
  "statuscol",
  dev = true,
  enabled = HVIM.plugins.statuscol,
  -- event = { "BufWinEnter" },
  event = "VeryLazy",
  opts = {
    ft_ignore = { "neo-tree", "alpha", "lazy", "help", "fzf", "TelescopePrompt", "TelescopeResult" },
    bt_ignore = { "terminal", "nofile", "prompt", "help", "quickfix" },
    -- wrap = { "markdown" },
  },
}
