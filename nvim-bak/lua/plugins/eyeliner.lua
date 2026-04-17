return {
  "jinh0/eyeliner.nvim",
  enabled = HVIM.plugins.eyeliner,
  event = { "BufReadPre", "BufNewFile" },
  opts = {
    highlight_on_key = true,
    default_keymaps = true,
    dim = true,
    max_length = 100,
    disabled_filetypes = { "alpha", "neo-tree", "fzf", "mason", "lazy" },
    disabled_buftypes = { "terminal", "nofile", "prompt", "help", "quickfix" },
  },
}
