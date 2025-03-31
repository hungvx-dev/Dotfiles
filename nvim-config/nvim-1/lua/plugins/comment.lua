return {
  {
    "echasnovski/mini.comment",
    event = { "BufReadPost", "BufNewFile" },
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
    cmd = {
      -- "TodoTrouble",
      "TodoFzflua",
    },
    event = { "BufReadPost", "BufNewFile", "BufWritePre" },
    keys = {
      {
        "]t",
        function()
          require("todo-comments").jump_next()
        end,
        desc = "Next todo comment",
      },
      {
        "[t",
        function()
          require("todo-comments").jump_prev()
        end,
        desc = "Previous todo comment",
      },
      -- { "<leader>xt", "<cmd>TodoTrouble<cr>", desc = "Todo (Trouble)" },
      -- { "<leader>xT", "<cmd>TodoTrouble keywords=TODO,FIX,FIXME<cr>", desc = "Todo/Fix/Fixme (Trouble)" },
      { "<leader>ft", "<cmd>TodoFzflua<cr>", desc = "Todo" },
      { "<leader>fT", "<cmd>TodoFzflua keywords=TODO,FIX,FIXME<cr>", desc = "Todo/Fix/Fixme" },
    },
    opts = {
      signs = true,
      sign_priority = 8,
      keywords = {
        -- FIX: Fix
        -- TODO: Todo
        -- HACK: Hack
        -- WARN: Warn
        -- PERF: Perf
        -- NOTE: Note
        -- TEST: Test
        FIX = { icon = HVIM.icons.Comment.Fix },
        TODO = { icon = HVIM.icons.Comment.Todo },
        HACK = { icon = HVIM.icons.Comment.Hack, color = "hack" },
        WARN = { icon = HVIM.icons.Comment.Warn },
        PERF = { icon = HVIM.icons.Comment.Perf },
        NOTE = { icon = HVIM.icons.Comment.Note },
        TEST = { icon = HVIM.icons.Comment.Test },
      },
      colors = {
        test = { "@comment.test" },
        hack = { "@comment.hack" },
      },
      highlight = {
        before = "",
        keyword = "wide",
        after = "fg",
        comments_only = true,
      },
    },
  },
}
