local eyeliner = require("eyeliner")

vim.g.clever_f_across_no_line = 1
-- vim.g.clever_f_timeout_ms = 200

vim.keymap.set({ "n", "x", "o" }, "f", function()
  eyeliner.highlight({ forward = true })
  return "<Plug>(clever-f-f)"
end, { expr = true })
vim.keymap.set({ "n", "x", "o" }, "F", function()
  eyeliner.highlight({ forward = true })
  return "<Plug>(clever-f-F)"
end, { expr = true })
