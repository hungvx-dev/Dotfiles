return {
  {
    "ibhagwan/fzf-lua",
    enabled = HVIM.plugins.fzf,
    cmd = "FzfLua",
    opts = {
      -- fzf_colors = false,
      fzf_colors = {
        true,
        ["fg"] = "#ffffff",
        ["fg+"] = "#5fd7ff:underline:bold",
        ["bg"] = "-1",
        ["bg+"] = "-1",
        ["hl"] = "#d7005f",
        ["hl+"] = "#d7005f:underline:bold",
        ["info"] = "#ffffff",
        ["gutter"] = "-1",
      },
      -- fzf_opts = {
      --   ["--no-reverse"] = "",
      -- },
      defaults = {
        file_icons = "mini",
        prompt = HVIM.icons.UI.Search,
        formatter = "path.dirname_first",
      },
      winopts = {
        preview = {
          layout = "vertical",
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

      -- Search
      { "<leader>fd", "<cmd>FzfLua diagnostics_document<cr>", desc = "Diagnostics" },
      { "<leader>fk", "<cmd>FzfLua keymaps<cr>", desc = "Key Maps" },
      { "<leader>fh", "<cmd>FzfLua help_tags<cr>", desc = "Help Tags" },
      { "<leader>fH", "<cmd>FzfLua highlights<cr>", desc = "Search Highlight Groups" },
      { "<leader>fm", "<cmd>FzfLua marks<cr>", desc = "Jump to Mark" },
      { "<leader>f:", "<cmd>FzfLua command_history<cr>", desc = "Command History" },

      -- Git
      { "<leader>fgs", "<cmd>FzfLua git_status<cr>", desc = "Git status" },
      { "<leader>fgb", "<cmd>FzfLua git_branches<cr>", desc = "Git branches" },
    },
  },
}
