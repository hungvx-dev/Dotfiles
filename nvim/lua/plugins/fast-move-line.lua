-- Quick-scope
vim.g.qs_filetype_blacklist = { "dashboard", "startify", "nvim-tree", 
"NvimTree", "Trouble" }
vim.g.qs_buftype_blacklist = { "terminal", "nofile" }
vim.g.qs_lazy_highlight = 1

-- Clever-f
-- vim.g.clever_f_ignore_case = 1
vim.g.clever_f_across_no_line = 1
-- if has("timers") then
-- vim.g.gs_delay = 300
-- else
-- vim.g.qs_lazy_highlight = 1
-- 	vim.g.qs_highlight_on_keys = { "f", "F", "t", "T" }
-- end