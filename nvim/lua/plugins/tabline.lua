return {
  "tabline",
  dev = true,
  -- lazy = false,
  enabled = false,
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
