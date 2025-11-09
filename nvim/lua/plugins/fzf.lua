return {
  {
    "ibhagwan/fzf-lua",
    enabled = HVIM.plugins.fzf,
    cmd = "FzfLua",
    opts = {
      "skim",
      fzf_bin = "sk",
      fzf_colors = { -- sk
        ["fg"] = "#ffffff",
        ["bg"] = "-1",
        ["current"] = "#00ffff",
        ["current_bg"] = "-1",
        ["current_match"] = "#d7005f",
        ["current_match_bg"] = "-1",
        ["matched"] = "#d7005f",
        ["matched_bg"] = "-1",
        ["info"] = "#ffffff",
        ["gutter"] = "-1",
      },
      -- fzf_opts = {
      --   ["--ansi"] = true,
      --   ["--height"] = "100%",
      --   ["--layout"] = "reverse",
      -- },
      -- fzf_colors = { -- fzf
      --   ["fg"] = "#ffffff",
      --   ["fg+"] = "#5fd7ff:underline:bold",
      --   ["bg"] = "-1",
      --   ["bg+"] = "-1",
      --   ["hl"] = "#d7005f",
      --   ["hl+"] = "#d7005f:underline:bold",
      --   ["info"] = "#ffffff",
      --   ["gutter"] = "-1",
      -- },
      -- fzf_opts = {
      --   ["--no-reverse"] = "",
      -- },
      defaults = {
        file_icons = "mini",
        prompt = HVIM.icons.UI.Search,
        formatter = "path.dirname_first",
      },
      winopts = {
        height = 0.9,
        width = 0.9,
        preview = {
          -- layout = "vertical",
          layout = "flex",
        },
      },
      files = {
        cwd_prompt = false,
        actions = false,
        -- fd_opts = [[--color=never --hidden --type f --type l --exclude .git]],
      },
      grep = {
        actions = false,
        -- actions = {
        --   ["alt-i"] = { actions.toggle_ignore },
        --   ["alt-h"] = { actions.toggle_hidden },
        -- },
      },
      lsp = {
        cwd_only = true,
        -- symbols = {
        --   symbol_hl = function(s)
        --     return "TroubleIcon" .. s
        --   end,
        --   symbol_fmt = function(s)
        --     return s:lower() .. "\t"
        --   end,
        --   child_prefix = false,
        -- },
        -- code_actions = {
        --   previewer = vim.fn.executable("delta") == 1 and "codeaction_native" or nil,
        -- },
      },
      oldfiles = {
        cwd_only = true,
      },
      buffers = {
        cwd_only = true,
      },
      keymap = {
        builtin = {
          ["<C-f>"] = "preview-page-down",
          ["<C-b>"] = "preview-page-up",
          ["<C-d>"] = "preview-down",
          ["<C-u>"] = "preview-up",
        },
      },
    },
    keys = {
      -- Files and buffers
      { "<leader>fb", "<cmd>FzfLua buffers sort_mru=true sort_lastused=true<cr>", desc = "Buffers" },
      { "<leader>fp", "<cmd>FzfLua files<cr>", desc = "Find Files (root dir)" },
      { "<leader>fo", "<cmd>FzfLua oldfiles<cr>", desc = "Recent" }, -- git

      -- Search
      { "<leader>fs", "<cmd>FzfLua live_grep<cr>", desc = "Find in Files (Grep)" },
      { "<leader>fi", "<cmd>FzfLua grep_curbuf<cr>", desc = "Buffer" },

      { "<leader>fd", "<cmd>FzfLua diagnostics_document<cr>", desc = "Diagnostics" },
      { "<leader>fk", "<cmd>FzfLua keymaps<cr>", desc = "Key Maps" },
      { "<leader>fh", "<cmd>FzfLua help_tags<cr>", desc = "Help Tags" },
      { "<leader>fH", "<cmd>FzfLua highlights<cr>", desc = "Search Highlight Groups" },
      { "<leader>fm", "<cmd>FzfLua marks<cr>", desc = "Jump to Mark" },
      { "<leader>f:", "<cmd>FzfLua command_history<cr>", desc = "Command History" },

      -- Git
      { "<leader>fgs", "<cmd>FzfLua git_status<cr>", desc = "Git status" },
      { "<leader>fgb", "<cmd>FzfLua git_branches<cr>", desc = "Git branches" },

      -- Git
      { "<leader>fl", "<cmd>FzfLua lsp_document_symbols<cr>", desc = "Lsp document symbols" },
    },
  },
  {
    "folke/todo-comments.nvim",
    enabled = HVIM.plugins.fzf,
    -- stylua: ignore
    keys = {
      { "<leader>ft", function() require("todo-comments.fzf").todo() end, desc = "Todo" },
      { "<leader>fT", function () require("todo-comments.fzf").todo({ keywords = { "TODO", "FIX", "FIXME" } }) end, desc = "Todo/Fix/Fixme" },
    },
  },
}
