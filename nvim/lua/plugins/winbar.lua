return {
  "winbar",
  dev = true,
  enabled = HVIM.plugins.winbar,
  event = { "VeryLazy" },
  opts = {
    separator = HVIM.icons.UI.WinBar,
    head = HVIM.icons.UI.Line.WinBar,
    depth_limit_indicator = HVIM.icons.UI.Ellipsis,
    ft_ignore = { "neo-tree", "alpha", "lazy", "help", "fzf", "man", "TelescopePrompt", "TelescopeResult", "mason" },
    bt_ignore = { "terminal", "nofile", "prompt", "help", "quickfix" },
  },
}
