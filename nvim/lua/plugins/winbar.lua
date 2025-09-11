return {
  {
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
  },
  {
    "SmiteshP/nvim-navic",
    enabled = HVIM.plugins.navic,
    opts = {
      -- icons = HVIM.icons.Kind,
      -- lsp = {
      --   auto_attach = false,
      --   preference = nil,
      -- },
      highlight = true,
      separator = HVIM.icons.UI.Winbar,
      depth_limit = 2,
      depth_limit_indicator = HVIM.icons.UI.Ellipsis,
      safe_output = true,
      -- lazy_update_context = false,
      -- lazy_update_context = true,
      click = false,
      -- format_text = function(text)
      --   return text
      -- end,
    },
  },
}
