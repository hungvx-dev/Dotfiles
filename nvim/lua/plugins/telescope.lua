local function find_command()
  if 1 == vim.fn.executable("rg") then
    return { "rg", "--files", "--color", "never", "-g", "!.git" }
  elseif 1 == vim.fn.executable("fd") then
    return { "fd", "--type", "f", "--color", "never", "-E", ".git" }
  elseif 1 == vim.fn.executable("fdfind") then
    return { "fdfind", "--type", "f", "--color", "never", "-E", ".git" }
  elseif 1 == vim.fn.executable("find") and vim.fn.has("win32") == 0 then
    return { "find", ".", "-type", "f" }
  elseif 1 == vim.fn.executable("where") then
    return { "where", "/r", ".", "*" }
  end
end

return {
  {
    enabled = not HVIM.plugins.fzf,
    "nvim-telescope/telescope.nvim",
    cmd = "Telescope",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "mini.icons",
      {
        "nvim-telescope/telescope-fzf-native.nvim",
        build = "make",
      },
    },
    opts = function()
      local actions = require("telescope.actions")
      -- local vimgrep_arguments = { unpack(telescopeConfig.values.vimgrep_arguments) }
      --
      -- table.insert(vimgrep_arguments, "--hidden")
      -- table.insert(vimgrep_arguments, "--glob")
      -- table.insert(vimgrep_arguments, "!**/.git/*")

      return {
        defaults = {
          prompt_prefix = HVIM.icons.UI.Search,
          selection_caret = HVIM.icons.UI.SelectionCaret,
          path_display = { "truncate" },
          initial_mode = "insert",
          border = false,
          sorting_strategy = "ascending",
          layout_strategy = "vertical",
          layout_config = {
            vertical = {
              preview_cutoff = 5,
              prompt_position = "top",
              mirror = true,
            },
          },
          mappings = {
            i = {
              -- ["<c-t>"] = function(...)
              --   return require("trouble.providers.telescope").open_with_trouble(...)
              -- end,
              -- ["<a-t>"] = function(...)
              --   return require("trouble.providers.telescope").open_selected_with_trouble(...)
              -- end,
              ["<C-j>"] = actions.move_selection_next,
              ["<C-k>"] = actions.move_selection_previous,
              ["<C-i>"] = actions.cycle_history_next,
              ["<C-o>"] = actions.cycle_history_prev,
              ["<C-v>"] = actions.select_vertical,
              ["<C-s>"] = actions.select_horizontal,
              ["<C-u>"] = actions.preview_scrolling_up,
              ["<C-d>"] = actions.preview_scrolling_down,
              ["<C-q>"] = actions.close,
            },
            n = {
              ["q"] = actions.close,
              ["<C-n>"] = actions.cycle_history_next,
              ["<C-p>"] = actions.cycle_history_prev,
              ["<C-v>"] = actions.select_vertical,
              ["<C-s>"] = actions.select_horizontal,
            },
          },
          -- file_ignore_patterns = M.file_ignore_patterns,
          winblend = 0,
        },
        extensions = {
          fzf = {
            fuzzy = true,
            override_generic_sorter = true,
            override_file_sorter = true,
            case_mode = "smart_case",
          },
        },
      }
    end,
    keys = {
      -- Files and buffers
      { "<leader>fb", "<cmd>Telescope buffers<cr>", desc = "Buffers" },
      { "<leader>fp", "<cmd>Telescope find_files<cr>", desc = "Find Files (root dir)" },
      { "<leader>fo", "<cmd>Telescope oldfiles<cr>", desc = "Recent" },

      -- Search
      { "<leader>fs", "<cmd>Telescope live_grep<cr>", desc = "Find in Files (Grep)" },
      { "<leader>fi", "<cmd>Telescope current_buffer_fuzzy_find<cr>", desc = "Buffer" },
      { "<leader>fj", "<cmd>Telescope grep_string<cr>", desc = "Word (root dir)" },

      { "<leader>fd", "<cmd>Telescope diagnostics<cr>", desc = "Diagnostics" },
      { "<leader>fk", "<cmd>Telescope keymaps<cr>", desc = "Key Maps" },
      { "<leader>fh", "<cmd>Telescope help_tags<cr>", desc = "Help Tags" },
      { "<leader>fH", "<cmd>Telescope highlights<cr>", desc = "Search Highlight Groups" },
      { "<leader>f:", "<cmd>Telescope command_history<cr>", desc = "Command History" },
    },
    config = function(_, opts)
      local telescope = require("telescope")
      telescope.setup(opts)
      telescope.load_extension("fzf")
    end,
  },

  {
    "folke/todo-comments.nvim",
    optional = true,
    -- stylua: ignore
    keys = {
      { "<leader>ft", "<cmd>TodoTelescope<cr>", desc = "Todo" },
      { "<leader>fT", "<cmd>TodoTelescope keywords=TODO,FIX,FIXME<cr>", desc = "Todo/Fix/Fixme" },
    },
  },
}
