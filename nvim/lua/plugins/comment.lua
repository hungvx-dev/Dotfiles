return {
  {
    "echasnovski/mini.comment",
    event = { "BufReadPre", "BufNewFile" },
    opts = {
      options = {
        custom_commentstring = function()
          return require("ts_context_commentstring.internal").calculate_commentstring() or vim.bo.commentstring
        end,
      },
    },
  },
  {
    "JoosepAlviste/nvim-ts-context-commentstring",
    opts = { enable_autocmd = false },
  },
  {
    "folke/todo-comments.nvim",
    cmd = { "TodoTrouble", "TodoTelescope" },
    event = { "BufReadPost", "BufNewFile", "BufWritePre" },
    keys ={
      { "]t", function() require("todo-comments").jump_next() end, desc = "Next todo comment" },
      { "[t", function() require("todo-comments").jump_prev() end, desc = "Previous todo comment" },
      { "<leader>xt", "<cmd>TodoTrouble<cr>", desc = "Todo (Trouble)" },
      { "<leader>xT", "<cmd>TodoTrouble keywords=TODO,FIX,FIXME<cr>", desc = "Todo/Fix/Fixme (Trouble)" },
      { "<leader>ft", "<cmd>TodoTelescope<cr>", desc = "Todo" },
      { "<leader>fT", "<cmd>TodoTelescope keywords=TODO,FIX,FIXME<cr>", desc = "Todo/Fix/Fixme" },
    },
    opts = {
      signs = true,
      sign_priority = 8,
      keywords = {
        FIX = {
          alt = { "FIXME", "BUG", "ISSUE" },
        },
        WARN = { alt = { "WARNING" } },
        PERF = { alt = { "PERFORMANCE", "OPTIMIZE" } },
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
    },
  },
}
