return {
  "jinh0/eyeliner.nvim",
  enabled = HVIM.plugins.eyeliner,
  event = { "BufReadPre", "BufNewFile" },
  opts = {
    highlight_on_key = true,
    default_keymaps = true,
    dim = true,
    max_length = 100,
    disabled_filetypes = { "Trouble", "alpha", "notify", "neo-tree", "help" },
    disabled_buftypes = { "terminal", "nofile" },
  },
}
