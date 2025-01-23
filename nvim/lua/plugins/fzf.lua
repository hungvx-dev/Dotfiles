return {
  {
    "ibhagwan/fzf-lua",
    cmd = "FzfLua",
    opts = function(_, opts)
      -- local fzf = require("fzf-lua")

      local img_previewer ---@type string[]?
      for _, v in ipairs({
        { cmd = "ueberzug", args = {} },
        { cmd = "chafa", args = { "{file}", "--format=symbols" } },
        { cmd = "viu", args = { "-b" } },
      }) do
        if vim.fn.executable(v.cmd) == 1 then
          img_previewer = vim.list_extend({ v.cmd }, v.args)
          break
        end
      end

      return {
        fzf_colors = {
          true,
          ["fg+"] = "#5fd7ff:underline:bold",
          ["bg"] = "-1",
          ["bg+"] = "-1",
          ["hl"] = "#d7005f",
          ["hl+"] = "#d7005f:underline:bold",
          ["gutter"] = "-1",
        },
        -- fzf_opts = {
        --   ["--no-reverse"] = "",
        -- },
        defaults = {
          prompt = HVIM.icons.UI.Search,
          formatter = "path.dirname_first",
        },
        previewers = {
          builtin = {
            extensions = {
              ["png"] = img_previewer,
              ["jpg"] = img_previewer,
              ["jpeg"] = img_previewer,
              ["gif"] = img_previewer,
              ["webp"] = img_previewer,
            },
            ueberzug_scaler = "fit_contain",
          },
        },
        winopts = {
          title_pos = "center",
          preview = {
            layout = "vertical",
            title_pos = "center",
          },
        },
        files = {
          cwd_prompt = false,
          actions = false,
        },
        grep = {
          actions = false,
          -- actions = {
          --   ["alt-i"] = { actions.toggle_ignore },
          --   ["alt-h"] = { actions.toggle_hidden },
          -- },
        },
        -- lsp = {
        --   symbols = {
        --     symbol_hl = function(s)
        --       return "TroubleIcon" .. s
        --     end,
        --     symbol_fmt = function(s)
        --       return s:lower() .. "\t"
        --     end,
        --     child_prefix = false,
        --   },
        --   code_actions = {
        --     previewer = vim.fn.executable("delta") == 1 and "codeaction_native" or nil,
        --   },
        -- },
        keymap = {
          builtin = {
            ["<C-f>"] = "preview-page-down",
            ["<C-b>"] = "preview-page-up",
            ["<C-d>"] = "preview-down",
            ["<C-u>"] = "preview-up",
          },
        },
      }
    end,
    keys = {
      -- Files and buffers
      { "<leader>fb", "<cmd>FzfLua buffers<cr>", desc = "Buffers" },
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
    },
  },
}
