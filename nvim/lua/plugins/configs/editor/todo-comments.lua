local M = {}

-- ╭──────────────────────────────────────────────────────────╮
-- │  Key mappings                                             │
-- ╰──────────────────────────────────────────────────────────╯
-- stylua: ignore
M.keys = {
  { "]t", function() require("todo-comments").jump_next() end, desc = "Next todo comment" },
  { "[t", function() require("todo-comments").jump_prev() end, desc = "Previous todo comment" },
  { "<leader>xt", "<cmd>TodoTrouble<cr>", desc = "Todo (Trouble)" },
  { "<leader>xT", "<cmd>TodoTrouble keywords=TODO,FIX,FIXME<cr>", desc = "Todo/Fix/Fixme (Trouble)" },
  { "<leader>ft", "<cmd>TodoTelescope<cr>", desc = "Todo" },
  { "<leader>fT", "<cmd>TodoTelescope keywords=TODO,FIX,FIXME<cr>", desc = "Todo/Fix/Fixme" },
}

M.opts = {
  signs = true,
  sign_priority = 8,
  keywords = {
    FIX = {
      alt = { "FIXME", "BUG", "FIXIT", "ISSUE" },
    },
    WARN = { alt = { "WARNING" } },
    PERF = { alt = { "OPTIM", "PERFORMANCE", "OPTIMIZE" } },
  },
  highlight = {
    before = "",
    keyword = "wide",
    after = "",
    pattern = [[.*<(KEYWORDS)\s*:]],
    comments_only = true,
    max_line_len = 400,
    exclude = {},
  },
}

-- ╭──────────────────────────────────────────────────────────╮
-- │ Setup                                                    │
-- ╰──────────────────────────────────────────────────────────╯
function M.setup()
  local status_ok, todo_comments = pcall(require, "todo-comments")
  if not status_ok then
    return
  end

  todo_comments.setup(M.opts)
end

return M
