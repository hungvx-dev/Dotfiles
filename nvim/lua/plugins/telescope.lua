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
    "nvim-telescope/telescope.nvim",
    cmd = "Telescope",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "mini.icons",
      {
        "nvim-telescope/telescope-fzf-native.nvim",
        build = "cmake -S. -Bbuild -DCMAKE_BUILD_TYPE=Release && cmake --build build --config Release",
      },
    },
    keys = {
      { "<leader>fs", "<cmd>Telescope live_grep<cr>",                 desc = "Find in Files (Grep)" },
      { "<leader>fb", "<cmd>Telescope buffers<cr>",                   desc = "Buffers" },
      { "<leader>fp", "<cmd>Telescope find_files<cr>",                desc = "Find Files (root dir)" },
      { "<leader>fo", "<cmd>Telescope oldfiles<cr>",                  desc = "Recent" }, -- git
      { "<leader>fi", "<cmd>Telescope current_buffer_fuzzy_find<cr>", desc = "Buffer" },
      { "<leader>fd", "<cmd>Telescope diagnostics<cr>",               desc = "Diagnostics" },
      { "<leader>fj", "<cmd>Telescope grep_string<cr>",               desc = "Word (root dir)" },
      { "<leader>fk", "<cmd>Telescope keymaps<cr>",                   desc = "Key Maps" },
      { "<leader>fh", "<cmd>Telescope help_tags<cr>",                 desc = "Help Tags" },
      { "<leader>fH", "<cmd>Telescope highlights<cr>",                desc = "Search Highlight Groups" },
      { "<leader>fm", "<cmd>Telescope marks<cr>",                     desc = "Jump to Mark" },
      { "<leader>f:", "<cmd>Telescope command_history<cr>",           desc = "Command History" },
    },
    opts = function()
      local actions = require("telescope.actions")
      local telescopeConfig = require("telescope.config")
      local vimgrep_arguments = { unpack(telescopeConfig.values.vimgrep_arguments) }

      table.insert(vimgrep_arguments, "--hidden")
      table.insert(vimgrep_arguments, "--glob")
      table.insert(vimgrep_arguments, "!**/.git/*")

      return {
        defaults = {
          prompt_prefix = HVIM.icons.UI.Search,
          selection_caret = HVIM.icons.UI.SelectionCaret,
          path_display = { "smart" },
          initial_mode = "insert",
          vimgrep_arguments = vimgrep_arguments,
          get_selection_window = function()
            local wins = vim.api.nvim_list_wins()
            table.insert(wins, 1, vim.api.nvim_get_current_win())
            for _, win in ipairs(wins) do
              local buf = vim.api.nvim_win_get_buf(win)
              if vim.bo[buf].buftype == "" then
                return win
              end
            end
            return 0
          end,
          sorting_strategy = "ascending",
          layout_strategy = "vertical",
          layout_config = {
            preview_cutoff = 5,
            prompt_position = "top",
          },
          mappings = {
            i = {
              -- ["<c-t>"] = function(...)
              --   return require("trouble.providers.telescope").open_with_trouble(...)
              -- end,
              -- ["<a-t>"] = function(...)
              --   return require("trouble.providers.telescope").open_selected_with_trouble(...)
              -- end,
              ["<C-n>"] = actions.cycle_history_next,
              ["<C-p>"] = actions.cycle_history_prev,
              ["<C-j>"] = actions.move_selection_next,
              ["<C-k>"] = actions.move_selection_previous,
              ["<C-v>"] = actions.select_vertical,
              ["<C-x>"] = actions.select_horizontal,
              ["<C-u>"] = actions.preview_scrolling_up,
              ["<C-d>"] = actions.preview_scrolling_down,
              ["<C-b>"] = actions.results_scrolling_up,
              ["<C-f>"] = actions.results_scrolling_down,
              ["<C-q>"] = actions.close,
            },
            n = {
              ["q"] = function(...)
                return actions.close(...)
              end,
              ["<C-n>"] = actions.cycle_history_next,
              ["<C-p>"] = actions.cycle_history_prev,
              ["<C-v>"] = actions.select_vertical,
              ["<C-x>"] = actions.select_horizontal,
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
        pickers = {
          find_files = {
            find_command = find_command,
            hidden = true,
          },
          buffers = {
            mappings = {
              i = {
                ["<C-d>"] = actions.delete_buffer,
              },
              n = {
                ["dd"] = actions.delete_buffer,
              },
            },
          },
          colorscheme = {
            enable_preview = true,
          },
        },
      }
    end,
    config = function(_, opts)
      local telescope = require("telescope")
      telescope.setup(opts)
      telescope.load_extension("fzf")
    end,
  },
}
