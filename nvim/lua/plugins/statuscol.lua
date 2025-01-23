return {
  {
    "statuscol",
    dev = true,
    enabled = HVIM.plugins.statuscol,
    event = { "VimEnter" },
    opts = {
      ft_ignore = { "neo-tree", "alpha", "lazy", "help" },
      wrap = { "markdown" },
    },
  },
}
