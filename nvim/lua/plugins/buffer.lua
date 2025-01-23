return {
  "buffer",
  dev = true,
  -- lazy = false,
  enabled = HVIM.plugins.buffer,
  event = "VimEnter",
  -- event = { "VeryLazy" },
  dependencies = { "mini.icons" },
  opts = {},
  keys = {
    { "[b", "<cmd>bprevious<cr>", desc = "Prev Buffer" },
    { "]b", "<cmd>bnext<cr>", desc = "Next Buffer" },
    { "<leader>bd", HVIM.ui.bufremove, desc = "Delete Buffer" },
  },
}
